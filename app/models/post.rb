class Post < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :title, :body, :user
  validates :title, length: { in: 5..140 }, uniqueness: true
  validates :body, length: { minimum: 140 }

  scope :newest, -> { order('created_at DESC') }
  scope :popular, -> { where('rating > 0').order('rating DESC') }
  scope :active, -> { order('updated_at DESC') }

  def self.search_in_title_or_body(query)
    if query.blank?
      all
    else
      query = query.downcase.split(/\s+/).collect! { |e| "%#{e}%" }.join
      where('lower(body) LIKE :query OR lower(title) LIKE :query',
            query: "%#{query}%")
    end
  end

  def self.search_by_tag(tag)
      where('lower(tags) LIKE ?', "%#{tag.downcase}%")
  end
end
