class HomeController < ApplicationController
  def index
    
  end
  def feed
    if user_signed_in?
      @posts = Post.all # Assuming 'Feed' is your model representing feeds
    specific_user_id = current_user.id 
    @every_one_posts = Post.EveryOne.exclude_specific_user_posts(specific_user_id)
    @feeds = [@posts, @every_one_posts].flatten.uniq
  else
    # Handle the case where there is no authenticated user
    # For example, redirect to the login page or show an error message
  end
  end

  def friend_posts
    @friend_posts = current_user.friends.flat.map do |friend|
      friend.posts.where(post_type: "MyFriend")
    end
    @feed = [posts, every_one_posts, @friend_posts].flatten.unqi
    
end
end
