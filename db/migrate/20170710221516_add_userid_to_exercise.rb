class AddUseridToExercise < ActiveRecord::Migration[4.2]
  def change
      add_column :exercises, :user_id, :integer
  end
end
