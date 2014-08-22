class Proposal < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  has_many :comments

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
