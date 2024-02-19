json.extract! post, :id, :title, :description, :user_id, :post_type, :created_at, :updated_at
json.url post_url(post, format: :json)
