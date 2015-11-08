class User < ActiveRecord::Base
  has_many :posts
  has_secure_password

  validates :email, presence: true,
                    uniqueness: true,
                    email: true

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
