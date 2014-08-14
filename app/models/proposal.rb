class Proposal < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  has_many :comments

  def rating
    self.up - self.down
  end

end
