json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :tags
  json.username post.user.name
  json.url post_url(post, format: :json)
end
