require "open-uri"

class Workout < ApplicationRecord
  has_one_attached :photo
  after_save :set_content, if: -> { saved_change_to_focus? || saved_change_to_equipment? }
  
  def content
    if super.blank?
      set_content
    else
      super
    end
  end

  def set_content
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "You are a certified personal trainer helping people create custom workout routines. Please create a personalized workout routine based on the following details: - Available Equipment: #{equipment} - Workout Focus: #{focus}. The routine should include: 5 exercises with sets and reps as well as notes or tips for proper form or equipment use. Please format the response clearly using Markdown-style structure."}]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    update(content: new_content)
    return new_content
  end

  private

  def set_photo
    client = OpenAI::Client.new
    response = client.images.generate(parameters: {
      prompt: "An image of #{name}", size: "256x256"
    })

    url = response["data"][0]["url"]
    file =  URI.parse(url).open

    photo.purge if photo.attached?
    photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    return photo
  end
end
