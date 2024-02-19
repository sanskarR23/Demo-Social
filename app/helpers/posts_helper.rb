module PostsHelper
    def liked_user_ids(post)
        post.liked_users.pluck(:id)
      end
    def get_link_for_like_unlike(post)
        if liked_user_ids(post).include?(current_user.id)
            link_to "Unlike",unlike_post_path(post)
        else
            link_to "Like",like_post_path(post),data: {turbo_method: :get}
        end
    end
    def edit_dom_id(feed)
        "Edit_Feed_#{feed.id}" # Assuming 'feed' is the name of your model
      end
    def edit_dom_id(post)
        "Edit.Feed.#{post.id}"
    end
    def dom_id(post)
        "Feed.#{post.id}"
    end
    def like_dom_id(post)
        "Like.Feed.#{post.id}"
    end
end



  