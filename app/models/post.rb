class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments, dependent: :destroy, order: 'created_at DESC'
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true
  before_save :generate_slug
  # before_create will generate slug once only. 
  # helpful if we don't want the slug to change on update, etc.

  def total_votes
    upvotes - downvotes
  end

  def upvotes
    votes.where(vote: true).size
  end

  def downvotes
    votes.where(vote: false).size
  end

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.title.gsub(/\p{^Alnum}/, '-').downcase
  end

end