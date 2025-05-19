require "open-uri"

class Workout < ApplicationRecord
  has_one_attached :photo
  after_save :generate_workout_content, if: -> { saved_change_to_focus? || saved_change_to_equipment? }
  
  def content
    super.presence || generate_workout_content
  end

  def photo_url
    return unless photo.attached?
    
    if Rails.application.config.active_storage.service == :cloudinary
      # For Cloudinary
      photo.key
    else
      # For local storage
      Rails.application.routes.url_helpers.url_for(photo)
    end
  end

  private

  def generate_workout_content
    generate_content
    set_photo
  rescue OpenAI::Error => e
    Rails.logger.error "OpenAI Error: #{e.message}"
    nil
  end

  def generate_content
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{
          role: "user",
          content: <<~PROMPT
            As a certified personal trainer, create a workout routine with:
            - Equipment: #{equipment}
            - Focus: #{focus}

            Provide 5 exercises in this exact format using Markdown-style structure:
            Exercise 1: [Name]
            Sets/Reps: [X sets x Y reps]
            Notes: [Tips]
            ---
            Exercise 2: [Name]
            ...
          PROMPT
        }]
      }
    )

    update(content: response.dig("choices", 0, "message", "content"))
  end

  def set_photo
    exercises = content.scan(/Exercise \d+: (.+)/).flatten
    return if exercises.empty?

    client = OpenAI::Client.new
    response = client.images.generate(
      parameters: {
        model: "dall-e-3",
        prompt: "A professional fitness illustration showing these 5 exercises: #{exercises.join(', ')}",
        size: "1024x1024"
      }
    )

    image_url = response.dig("data", 0, "url")
    downloaded_image = URI.open(image_url)

    photo.purge if photo.attached?
    photo.attach(
      io: downloaded_image,
      filename: "workout_#{id}_exercises.jpg",
      content_type: "image/jpeg"
    )
  rescue => e
    Rails.logger.error "Failed to generate workout image: #{e.message}"
    nil
  end
end
