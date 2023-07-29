class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :comments
  has_many :likes

  attribute :posts_count, :integer, default: 0

  validates :name, presence: true, length: { minimum: 2 }
  validates :bio, presence: true, length: { in: 2..250 }
  validates :posts_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.includes(:author).order(created_at: :asc).limit(3)
  end
end
