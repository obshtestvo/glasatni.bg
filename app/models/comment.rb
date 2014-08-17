class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal

  has_many :votings, as: :votable

  def rating
    self.up - self.down
  end

end
