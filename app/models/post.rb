class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy, order: 'created_at DESC'
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true

  def total_votes
    upvotes - downvotes
  end

  def upvotes
    votes.where(vote: true).size
  end

  def downvotes
    votes.where(vote: false).size
  end

end