class SessionsController < ApplicationController
  def new
  end

  def create
    @session = Session.new(params)
    if @session.valid?
      session[:user_id] = @session.user.id
      respond_to do |format|
        format.html do
          flash[:success] = 'You successfully logging in'
          redirect_to posts_path
        end
        format.js { render action: 'success_login' }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:alert] = 'Something went wrong. Check errors and try again'
          render action: 'new'
        end
        format.js { render action: 'failed_login' }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logged out'
    redirect_to root_url
  end
end