class AddWeightToExercise < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :weight, :string
  end
end
