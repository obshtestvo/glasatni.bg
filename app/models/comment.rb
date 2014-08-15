class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :proposal

  def rating
    self.up - self.down
  end

end
