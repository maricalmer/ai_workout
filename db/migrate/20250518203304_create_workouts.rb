class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.string :equipment
      t.string :focus

      t.timestamps
    end
  end
end
