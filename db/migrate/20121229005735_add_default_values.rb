class AddDefaultValues < ActiveRecord::Migration
  def change
    change_column_default :recipes, :expected_curing_time, 0
    change_column_default :recipes, :expected_fermenting_time, 0
    change_column_default :recipes, :expected_drying_time, 0
  end
end
