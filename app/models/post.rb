class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { in: 5..100 }, uniqueness: true
  validates :body, presence: true

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
