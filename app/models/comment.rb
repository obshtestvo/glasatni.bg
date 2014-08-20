class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :proposal
  has_many :votings, as: :votable

  def rating
    self.up - self.down
  end

  def self.latest n
    Comment.order(created_at: :asc).limit(n)
  end

  def self.hottest n
    Comment.order(hotness: :desc).limit(n)
  end

end
