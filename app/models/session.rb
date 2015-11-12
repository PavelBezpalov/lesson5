class Session
  include ActiveModel::Validations

  attr_accessor :email, :password, :user

  def initialize(attributes = {})
    @email = attributes[:email]
    @password = attributes[:password]
    @user = User.find_by_email(@email)
  end

  validates :email, email: true, presence: true
  validates :password, presence: true

  validate :check_credits

  def check_credits
    return check_user_password if @user
    errors.add(:email, 'User not found')
  end

  def check_user_password
    return if @user.authenticate(@password)
    errors.add(:password, 'Password incorrect')
  end
end

