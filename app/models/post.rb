class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :content, presence: true
  
  if Rails.env.development?
    dropbox_path = "config/dropbox_local.yml"
  else 
    dropbox_path = "config/dropbox_heroku.yml"
  end 
  
  has_attached_file :image,
    :storage => :dropbox,
    :styles => { :medium =>"x200", :square => "146x146#"},
    :dropbox_credentials => Rails.root.join(dropbox_path),
    :path => ":style/:id_:filename"

  # Returns posts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
