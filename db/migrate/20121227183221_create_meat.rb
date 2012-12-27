class CreateMeat < ActiveRecord::Migration
  def change
    create_table(:meats) do |t|
      t.string :name
      t.integer :recipe_id
      t.integer :user_id
      t.integer :team_id
      t.integer :box_id
      t.decimal :initial_weight
      t.timestamps
    end
  end
end
