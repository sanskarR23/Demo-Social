
class CreatePostsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :posts_users do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      # Add any additional columns if needed
      t.timestamps
    end
  end
end
