class User < ActiveRecord::Base
  include Sluggable
  before_save { self.username = username.downcase }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password

  validates :username, presence: true, uniqueness:  { case_sensitive: false }, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 5 },
            on: :create

  sluggable_column :username


end