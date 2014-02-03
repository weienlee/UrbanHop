class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy                                   
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  
  
  if Rails.env.development?
    dropbox_path = "config/dropbox_local.yml"
  else 
    dropbox_path = "config/dropbox_heroku.yml"
  end 
  
  has_attached_file :avatar,
    :storage => :dropbox,
    :styles => { :square =>"200x200#", :thumb => "50x50#"},
    :dropbox_credentials => Rails.root.join(dropbox_path),
    :path => ":style/:id_:filename"
  
  #attr_accessor :avatar_file_name, :avatar_content_type, :avatar_file_size
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 120 }, on: :create
  validates :password, length: {minimum: 6, maximum: 120 }, on: :update, allow_blank: true
  
  def User.search(search)
    if search
      if search.include? ' '
        User.where("lower(first_name) = ? AND lower(last_name) = ?", search.split.first.downcase, search.split.last.downcase)
      else
        User.where("lower(first_name) = ? OR lower(last_name) = ?", search.downcase, search.downcase)
      end
    else
      User.all
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def like!(liked_post)
    likes.create!(post_id: liked_post.id)
  end
  
  def unlike!(unliked_post)
    likes.find_by(post_id: unliked_post.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
    
end
