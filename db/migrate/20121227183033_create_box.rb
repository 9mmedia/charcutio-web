class CreateBox < ActiveRecord::Migration
  def change
    create_table(:boxes) do |t|
      t.string :name
      t.integer :team_id
      t.string :twitter_oauth_token
      t.string :twitter_oauth_secret
      t.timestamps
    end
  end
end
