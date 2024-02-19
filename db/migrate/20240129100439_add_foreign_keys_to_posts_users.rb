class AddForeignKeysToPostsUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :posts_users, :post_id, :integer
    add_column :posts_users, :user_id, :integer
    add_foreign_key :posts_users, :posts
    add_foreign_key :posts_users, :users
  end
end
