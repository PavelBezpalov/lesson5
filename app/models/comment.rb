class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :user
  belongs_to :post

  validates_presence_of :user, :post, :body

  after_create { post.touch }

  scope :desc, -> { order('created_at DESC') }
  scope :asc, -> { order('created_at ASC') }

  def rule_5_minutes?
    (self.created_at + 5.minutes) > Time.new
  end

  def timeleft
    ((self.created_at + 5.minutes) - Time.new).to_i
  end
end
