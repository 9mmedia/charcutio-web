class AddBoxIdToDataPointsTable < ActiveRecord::Migration
  def change
    add_column :data_points, :box_id, :integer
  end
end
