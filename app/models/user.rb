class User <ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password

  validates :username, presence: true, uniqueness: true, length:{minimum: 5}
  validates :password, presence: true, length:{minimum: 5}, on: :create
end