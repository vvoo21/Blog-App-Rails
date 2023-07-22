class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  after_save :update_posts_count
  after_destroy :decrease_posts_count

  attribute :comments_count, :integer, default: 0
  attribute :likes_count, :integer, default: 0

  validates :title, presence: true, length: { in: 2..250 }
  validates :text, presence: true, length: { in: 2..600 }
  validates :comments_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.includes(:author).order(created_at: :asc).limit(5)
  end

  def update_posts_count
    author.increment!(:posts_count)
  end

  def decrease_posts_count
    author.decrement!(:posts_count)
  end
end
