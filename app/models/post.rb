class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  after_save :update_posts_count
  after_destroy :decrease_posts_count

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  def update_posts_count
    author.increment!(:posts_count)
  end

  def decrease_posts_count
    author.decrement!(:posts_count)
  end
end
