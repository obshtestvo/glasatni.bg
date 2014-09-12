class Proposal < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votings, as: :votable, dependent: :destroy

  def rating
    self.up - self.down
  end

  def self.latest n
    Proposal.order(created_at: :asc).limit(n)
  end

  def self.hottest n
    Proposal.order(hotness: :desc).limit(n)
  end

  def self.custom_order order

    case order
    when 'newest'    then by = { created_at: :asc }
    when 'oldest'    then by = { created_at: :desc }
    when 'relevance' then by = { hotness: :asc }
    else raise 'Unknown order param passed.'
    end

    order(by)
  end

end
