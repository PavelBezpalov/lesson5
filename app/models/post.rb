class Post < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user
  has_and_belongs_to_many :starred_users, class_name: 'User', join_table: 'starred'
  belongs_to :user

  validates_presence_of :title, :body, :user
  validates :title, length: { in: 5..140 }, uniqueness: true
  validates :body, length: { minimum: 140 }

  after_save :check_cover_image

  default_scope { order('created_at DESC') }

  def self.index_view_mode(params)
    select_view_mode(params[:mode])
    .search_by_tag(params[:tag])
    .search_in_title_or_body(params[:search])
  end

  protected

  def check_cover_image
    if cover_image.include?('bandcamp.com') && cover_image.split(' ').count < 3
      Album.new(self).update
    end
  end

  private

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
end
