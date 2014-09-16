class Proposal < ActiveRecord::Base
  include Orderable

  belongs_to :theme, counter_cache: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votings, as: :votable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy

  self.per_page = 3

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
