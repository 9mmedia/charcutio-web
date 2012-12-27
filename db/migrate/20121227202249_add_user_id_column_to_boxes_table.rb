class AddUserIdColumnToBoxesTable < ActiveRecord::Migration
  def change
    add_column :boxes, :user_id, :integer
  end
end
