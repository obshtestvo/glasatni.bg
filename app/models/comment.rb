class Comment < ActiveRecord::Base
  include Orderable

  belongs_to :user
  belongs_to :proposal, counter_cache: true
  has_many :votings, as: :votable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy

  after_save    :update_user_rank
  after_destroy :update_user_rank

  paginates_per 3

  def self.latest n
    Comment.order(created_at: :asc).limit(n)
  end

  def self.hottest n
    Comment.order(hotness: :desc).limit(n)
  end

  private
  def update_user_rank
    user = self.user
    count = user.comments.count

    case count
    when 0..2 then rank = "observer"
    when 3..7 then rank = "speaker"
    else rank = "orator"
    end

    user.comments_rank = rank
    user.save
  end
end
