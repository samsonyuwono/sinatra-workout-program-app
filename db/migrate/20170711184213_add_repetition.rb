class AddRepetition < ActiveRecord::Migration
  def change
    add_column :exercises, :repetition, :integer
  end
end
