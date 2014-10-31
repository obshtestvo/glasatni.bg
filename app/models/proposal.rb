class Proposal < ActiveRecord::Base
  include Orderable

  belongs_to :theme, counter_cache: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votings, as: :votable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy

  validates :title, presence: true

  after_save :update_user_rank
  after_destroy :update_user_rank

  paginates_per 3

  private
  def update_user_rank
    user = self.user
    count = user.proposals.count

    case count
    when 0..2 then rank = "enthusiast"
    when 3..7 then rank = "activist"
    else rank = "policy_maker"
    end

    user.proposals_rank = rank
    user.save
  end

end
