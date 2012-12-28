class AddDatesToMeat < ActiveRecord::Migration
  def change
    add_column :meats, :start_date, :datetime
    add_column :meats, :fermenting_start_date, :datetime
    add_column :meats, :drying_start_date, :datetime
    add_column :meats, :end_date, :datetime
  end
end
