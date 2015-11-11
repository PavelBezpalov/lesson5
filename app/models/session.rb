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

  validate :find_user_by_email,
           :check_user_password

  def find_user_by_email
    unless @user
      errors.add(:email, 'User not found')
    end
  end

  def check_user_password
    return unless @user
    unless @user.authenticate(@password)
      errors.add(:password, 'Password incorrect')
    end
  end
end

