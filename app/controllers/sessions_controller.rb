class SessionsController < ApplicationController
  def new
  end

  def create
    @session = Session.new(params)
    if @session.valid?
      session[:user_id] = @session.user.id
      flash[:success] = 'You successfully logging in'
      redirect_to posts_path
    else
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    redirect_to root_url
  end
end