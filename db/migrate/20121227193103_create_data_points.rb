class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.string :data_type
      t.float  :value

      t.timestamps
    end
  end
end
