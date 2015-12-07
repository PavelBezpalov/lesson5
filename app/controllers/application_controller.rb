class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :count_to_promo

  helper_method :set_promo_banner?, :current_user

  rescue_from User::NotAuthorized, with: :require_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      reset_session
  end

  def set_promo_banner?
    session[:promo_counter].nil?
  end

  def count_to_promo
    session[:promo_counter] ||= 0
    if session[:promo_counter] < 10
      session[:promo_counter] += 1
    else
      session[:promo_counter] = nil
    end
  end

  def require_user
    respond_to do |format|
      format.html do
        flash[:alert] = 'You must be logged in to access that action'
        redirect_to new_session_path
      end
      format.js { render partial: 'sessions/modal_new' }
    end
  end

  def check_authorization
    raise User::NotAuthorized unless current_user
  end
end
