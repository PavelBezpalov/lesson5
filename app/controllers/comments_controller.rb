class CommentsController < ApplicationController
  before_action :check_authorization

  def new
    @post = Post.find(params[:post_id])
    @parent_comment = Comment.find(params[:parent_id])
    @new_comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    begin
    @parent_comment = Comment.find(params[:comment][:parent_id])
    rescue ActiveRecord::RecordNotFound
    end
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      @new_comment = @post.comments.new
      respond_to do |format|
        format.html do
          flash[:success] = 'Your comment has been posted.'
          redirect_to @post
        end
        format.js
      end
    else
      @new_comment = @comment
      respond_to do |format|
        format.html { render @post }
        format.js { render action: 'failed_save' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
