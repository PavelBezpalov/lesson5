class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_presence_of :user, :post

  after_create :set_rating
  after_destroy :revert_rating

  protected

  def set_rating
    new_rating = post.rating
    if self.positive
      new_rating += 1
    else
      new_rating -= 1
    end
    post.update_columns(rating: new_rating)
  end

  def revert_rating
    new_rating = post.rating
    if self.positive
      new_rating -= 1
    else
      new_rating += 1
    end
    post.update_columns(rating: new_rating)
  end
end
