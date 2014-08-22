class Proposal < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votings, as: :votable, dependent: :destroy

  def rating
    self.up - self.down
  end

  def self.latest n
    Proposal.order(created_at: :asc).limit(n)
  end

  def self.hottest n
    Proposal.order(hotness: :desc).limit(n)
  end

end
