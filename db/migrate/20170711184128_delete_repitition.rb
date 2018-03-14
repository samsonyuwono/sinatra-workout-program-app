class DeleteRepitition < ActiveRecord::Migration[4.2]
  def change
    remove_column :exercises, :repitition
  end
end
