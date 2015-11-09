module UsersHelper
  def user_field_class(key)
    return 'errors' if @user.errors[key].present?
    return 'errors' if key == :password &&
        @user.errors[:password_confirmation].present?
    'group'
  end

  def user_error_message(key)
    @user.errors[key].first
  end
end
