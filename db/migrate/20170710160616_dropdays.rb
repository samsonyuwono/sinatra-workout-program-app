class Dropdays < ActiveRecord::Migration
  def change
    drop_table :days do |t|
      t.string :name, null: false
    end
  end
end
