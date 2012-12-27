class RemoveTwitterOauthFromBox < ActiveRecord::Migration
  def up
    remove_column :boxes, :twitter_oauth_token
    remove_column :boxes, :twitter_oauth_secret
  end

  def down
    add_column :boxes, :twitter_oauth_token, :string
    add_column :boxes, :twitter_oauth_secret, :string
  end
end
