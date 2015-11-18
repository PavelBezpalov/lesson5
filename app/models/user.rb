class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password

  validates :email, presence: true,
                    uniqueness: true,
                    email: true

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end

  class NotAuthorized < StandardError
  end
end
