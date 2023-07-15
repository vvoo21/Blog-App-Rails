class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post
  after_save :update_likes_count
  after_destroy :decrease_likes_count

  def update_likes_count
    post.increment!(:likes_count)
  end

  def decrease_likes_count
    post.decrement!(:likes_count)
  end
end
