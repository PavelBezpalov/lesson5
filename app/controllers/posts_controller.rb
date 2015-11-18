class PostsController < ApplicationController
  before_action :check_authorization, except: [:index, :show, :popular, :active]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :rate_system_checks, only: [:like, :dislike]

  def index
    return @posts = Post.search_by_tag(params[:tag]).newest if params[:tag]
    @posts = Post.search_in_title_or_body(params[:search]).newest
  end

  def popular
    @posts = Post.search_in_title_or_body(params[:search]).popular.newest
    render :index
  end

  def active
    @posts = Post.active
    render :index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post,
                      notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        flash.now[:alert] = 'Something went wrong. Check errors and try again'
        format.html { render :new }
        format.json { render json: @post.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post,
                      notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        flash.now[:alert] = 'Something went wrong. Check errors and try again'
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url,
                    notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    Vote.create(user: current_user, post: @post)
    redirect_to :back,
                notice: 'You positive rate was submitted.'
  end

  def dislike
    Vote.create(user: current_user, post: @post, positive: false)
    redirect_to :back,
                notice: 'You negative rate was submitted.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :tags)
  end

  def check_post_owner
    if @post.user == current_user
      redirect_to :back, alert: 'You can\'t rate own posts'
    end
  end

  def check_already_rated
    if @post.voters.include?(current_user)
      redirect_to :back, alert: 'You already rate this post'
    end
  end

  def rate_system_checks
    set_post
    check_post_owner
    check_already_rated
  end
end
