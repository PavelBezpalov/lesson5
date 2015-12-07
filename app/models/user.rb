class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :starred_posts, class_name: 'Post', join_table: 'starred'
  has_secure_password

  validates :name, presence: true,
                   uniqueness: true
  validates :email, presence: true,
                    uniqueness: true,
                    email: true

  before_save :downcase_email

  def name
    return Faker::Name.name if self[:name] == ''
    self[:name]
  end

  def to_param
    "#{id}-#{name.downcase.gsub(' ', '-')}"
  end

  def rating
    posts.sum(:rating)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  class NotAuthorized < StandardError
  end
end
