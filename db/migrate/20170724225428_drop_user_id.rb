class DropUserId < ActiveRecord::Migration
  def change
    remove_column :exercises, :user_id
  end
end
