class DeleteRepitition < ActiveRecord::Migration
  def change
    remove_column :exercises, :repitition
  end
end
