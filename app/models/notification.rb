class Notification < ActiveRecord::Base

  belongs_to :recipient, class_name: :User, foreign_key: :user_id
  belongs_to :user
  belongs_to :proposal

  paginates_per 5

  enum action: [:proposal_created, :comment_created]
end
