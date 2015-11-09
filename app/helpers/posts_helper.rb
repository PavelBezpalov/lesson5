module PostsHelper
  def post_field_class(key)
    return 'errors' if @post.errors[key].present?
    'group'
  end

  def post_error_message(key)
    @post.errors[key].join
  end
end
