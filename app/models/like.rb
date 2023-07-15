class Like < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :update_likes_count
  after_destroy :decrease_likes_count

  def update_likes_count
    post.increment!(:likes_count)
  end

  def decrease_likes_count
    post.decrement!(:likes_count)
  end
end
