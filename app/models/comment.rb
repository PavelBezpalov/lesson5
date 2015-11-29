class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :user
  belongs_to :post

  validates_presence_of :user, :post, :body

  after_create { post.touch }

  default_scope { order('created_at DESC') }
end
