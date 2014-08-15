class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :proposals
  has_many :comments

  enum role: [:registered, :moderator, :admin]

  def isAdmin?
    self.role == "admin"
  end

  def isRegistered?
    self.role == "registered"
  end

  def isModerator?
    self.role == "moderator"
  end

end
