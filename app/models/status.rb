class Status < ActiveRecord::Base
  belongs_to :proposal, dependent: :destroy

  enum kinds: [:approved, :submitted, :not_submitted, :rejected_no_reason, :rejected_with_reason, :accepted, :in_force]
end
