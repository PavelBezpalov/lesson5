module SessionsHelper
  def session_field_class(key)
    return 'group' if session[:errors].nil? || session[:errors][key].blank?
    'errors'
  end

  def session_error_message(key)
    session[:errors][key] unless session[:errors].nil?
  end
end
