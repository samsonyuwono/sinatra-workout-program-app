class CreateExercises < ActiveRecord::Migration[4.2]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :repitition
      t.integer :sets
    end
  end
end
