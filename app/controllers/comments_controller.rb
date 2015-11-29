class CommentsController < ApplicationController
  before_action :check_authorization

  def create
    @comment = Comment.new(body: params[:body])
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    @comment.save
  end
end
