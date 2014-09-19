class Comment < ActiveRecord::Base
  include Orderable

  belongs_to :user
  belongs_to :proposal, counter_cache: true
  has_many :votings, as: :votable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy

  paginates_per 3

  def self.latest n
    Comment.order(created_at: :asc).limit(n)
  end

  def self.hottest n
    Comment.order(hotness: :desc).limit(n)
  end

end
