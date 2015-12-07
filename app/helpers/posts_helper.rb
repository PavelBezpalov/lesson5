module PostsHelper
  def posts_index_title
    if params[:mode] && params[:tag]
      "#{params[:mode].capitalize} Posts | Tag: #{params[:tag]}"
    elsif params[:mode]
      "#{params[:mode].capitalize} Posts"
    elsif params[:tag]
      "Tag: #{params[:tag]}"
    end
  end
end
