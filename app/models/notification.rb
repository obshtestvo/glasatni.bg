class Notification < ActiveRecord::Base

  belongs_to :recipient, class: User
  belongs_to :user
  belongs_to :proposal

  enum action: [:proposal_created]
end
