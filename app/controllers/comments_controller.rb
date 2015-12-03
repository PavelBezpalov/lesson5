class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :edit, :update]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :check_authorization
  before_action :check_modify_permissions, only: [:edit, :update, :destroy]

  def new
    @parent_comment = Comment.find(params[:parent_id])
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    begin
      @parent_comment = Comment.find(params[:comment][:parent_id])
    rescue ActiveRecord::RecordNotFound
    end
    if @comment.save
      @new_comment = @post.comments.new
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render action: 'failed_save' }
      end
    end
  end

  def edit
  end

  def update
    @parent_comment = @comment.parent if @comment.parent
    if @comment.update(body: params[:comment][:body])
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render action: 'failed_save' }
      end
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def check_modify_permissions
    unless @comment.user == current_user || @comment.rule_5_minutes?
      respond_to do |format|
        flash[:alert] = 'Permission denied.'
        format.js { render js: "window.location = '#{new_session_path}'" }
      end
    end
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
