json.extract! @post, :id, :title, :body, :tags, :created_at
json.username @post.user.name
