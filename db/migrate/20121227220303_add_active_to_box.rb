class AddActiveToBox < ActiveRecord::Migration
  def change
    add_column :boxes, :active, :boolean
  end
end
