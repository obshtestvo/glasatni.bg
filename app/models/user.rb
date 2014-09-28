class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

  has_many :proposals
  has_many :comments
  has_many :votings
  has_many :flags

  enum role: [:registered, :moderator, :admin]
  enum comments_rank: [:observer, :speaker, :orator]
  enum proposals_rank: [:enthusiast, :activist, :policy_maker]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name    # assuming the user model has a name
      user.avatar = auth.info.image # assuming the user model has an image
    end
  end

end
