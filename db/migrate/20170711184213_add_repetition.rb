class AddRepetition < ActiveRecord::Migration[4.2]
  def change
    add_column :exercises, :repetition, :integer
  end
end
