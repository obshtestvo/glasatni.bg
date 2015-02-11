class Proposal < ActiveRecord::Base
  include Orderable
  include Notificationable

  belongs_to :theme, counter_cache: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votings, as: :votable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy
  has_many :statuses

  validates :title, presence: true

  after_create :after_create_callbacks
  after_destroy :update_user_rank

  paginates_per 25

  scope :approved, -> { where(approved: true) }

  private

  def after_create_callbacks
    update_user_rank
    create_notification :proposal_created
  end

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
