class AddAddressToBox < ActiveRecord::Migration
  def change
    add_column :boxes, :address, :string
  end
end
