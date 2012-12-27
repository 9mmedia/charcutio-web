class CreateRecipe < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.string :name
      t.integer :user_id
      t.integer :team_id
      t.decimal :initial_water_percentage
      t.boolean :fermented
      t.integer :approximate_diameter
      t.integer :expected_curing_time
      t.integer :expected_fermenting_time
      t.integer :expected_drying_time
      t.timestamps
    end
  end
end
