class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  before_create :generate_token

  has_many :proposals
  has_many :comments
  has_many :votings
  has_many :flags
  has_one :theme

  paginates_per 3

  scope :subscribed, -> { where(subscribed: true) }

  enum role: [:registered, :moderator]
  enum comments_rank: [:observer, :speaker, :orator]
  enum proposals_rank: [:enthusiast, :activist, :policy_maker]

  def active_for_authentication?
    super && !self.banned?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  protected

  def generate_token
    self.api_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(api_token: random_token)
    end
  end

end
