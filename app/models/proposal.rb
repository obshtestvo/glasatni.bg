class Proposal < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  def rating
    self.up - self.down
  end

end
