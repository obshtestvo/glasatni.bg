class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal

  has_many :votings, as: :votable

  def rating
    self.up - self.down
  end

  def latest n
    Comment.order(:created_at).limit(n)
  end

  def hottest n
    Comment.order(:hotness).limit(n)
  end

end
