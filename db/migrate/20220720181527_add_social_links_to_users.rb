class AddSocialLinksToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :github_username, :string
    add_column :users, :twitter_username, :string
    add_column :users, :personal_website, :string
  end
end
