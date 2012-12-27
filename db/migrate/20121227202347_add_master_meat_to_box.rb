class AddMasterMeatToBox < ActiveRecord::Migration
  def change
    add_column :boxes, :master_meat_id, :integer
  end
end
