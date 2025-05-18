class AddContentToWorkouts < ActiveRecord::Migration[7.1]
  def change
    add_column :workouts, :content, :text
  end
end
