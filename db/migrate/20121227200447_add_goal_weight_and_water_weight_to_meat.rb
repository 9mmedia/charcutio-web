class AddGoalWeightAndWaterWeightToMeat < ActiveRecord::Migration
  def change
    add_column :meats, :goal_weight, :decimal
    add_column :meats, :initial_water_weight, :decimal
  end
end
