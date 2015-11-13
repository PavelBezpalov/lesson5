class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :body, :user
  validates :title, length: { in: 5..140 }, uniqueness: true
  validates :body, length: { minimum: 140 }

  scope :newest, -> { order('created_at DESC') }

  def self.search_in_title_or_body(query)
    if query.blank?
      all
    else
      query = query.downcase.split(/\s+/).collect! { |e| "%#{e}%" }.join
      where('lower(body) LIKE :query OR lower(title) LIKE :query',
            query: "%#{query}%")
    end
  end
end
