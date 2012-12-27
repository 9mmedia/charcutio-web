class CreateIngredient < ActiveRecord::Migration
  def change
    create_table(:ingredients) do |t|
      t.string :name
      t.decimal :water_percentage
      t.timestamps
    end
  end
end
