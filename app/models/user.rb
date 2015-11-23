class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :starred_posts, class_name: 'Post', join_table: 'starred'
  has_secure_password

  validates :email, presence: true,
                    uniqueness: true,
                    email: true

  before_save :downcase_email

  def name
    return Faker::Name.name if self[:name] == ''
    self[:name]
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  class NotAuthorized < StandardError
  end
end
