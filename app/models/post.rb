class Post < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :title, :body, :user
  validates :title, length: { in: 5..140 }, uniqueness: true
  validates :body, length: { minimum: 140 }

  default_scope { order('created_at DESC') }

  def self.search_in_title_or_body(query)
    if query
      query = query.downcase.split(/\s+/).collect! { |e| "%#{e}%" }.join
      where('lower(body) LIKE :query OR lower(title) LIKE :query',
            query: "%#{query}%")
    else
      all
    end
  end

  def self.search_by_tag(tag)
    if tag
      where('lower(tags) LIKE ?', "%#{tag.downcase}%")
    else
      all
    end
  end

  def self.select_view_mode(mode)
    if mode == 'popular'
      unscoped.where('rating > 0').order('rating DESC')
    elsif mode == 'active'
      unscoped.order('updated_at DESC')
    else
      all
    end
  end

  def self.index_view_mode(params)
    select_view_mode(params[:mode])
    .search_by_tag(params[:tag])
    .search_in_title_or_body(params[:search])
  end
end
