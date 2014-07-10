class User < ActiveRecord::Base
  before_save { self.username = username.downcase }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password

  validates :username, presence: true, uniqueness:  { case_sensitive: false }, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 5 },
            on: :create

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = to_slug(self.username)
    post = User.find_by slug: the_slug
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = User.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i !=0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str
  end

end