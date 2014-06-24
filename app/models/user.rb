class User <ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :username, presence: true, uniqueness: true, length:{minimum: 5}
  validates :password, length:{minimum: 5}
end