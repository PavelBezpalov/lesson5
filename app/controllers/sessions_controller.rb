class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    unless user
      session[:errors] = { email: 'User not found' }
      render action: 'new'
    else
      unless user.authenticate(params[:password])
        session[:errors] = { password: 'Password incorrect' }
        render action: 'new'
      else
        session[:user_id] = user.id
        flash[:success] = 'Your successfully logging in!'
        redirect_to posts_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end