class CommentsController < ApplicationController
  before_action :check_authorization

  def create
    comment = Comment.new(body: params[:body])
    comment.user = current_user
    comment.post = Post.find(params[:post_id])
    if comment.save
      redirect_to :back, notice: 'Your comment was added.'
    else
      redirect_to :back, alert: 'Something going wrong.'
    end
  end
end
