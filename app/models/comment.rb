class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post
  after_save :update_comments_count
  after_destroy :decrease_comments_count

  validates :text, presence: true, length: { in: 2..100 }

  def update_comments_count
    post.increment!(:comments_count)
  end

  def decrease_comments_count
    post.decrement!(:comments_count)
  end
end
