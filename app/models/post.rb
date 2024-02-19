class Post < ApplicationRecord
  belongs_to :user
has_many :feeds
has_many :likes
has_and_belongs_to_many  :liked_users, class_name:"User", source: :user

  enum post_type: {EveryOne:"EveryOne",OnlyMe:"OnlyMe",MyFriend:"MyFriend"}
  scope :exclude_specific_user_posts, ->(user_id) { where.not(user_id: user_id) }
end

