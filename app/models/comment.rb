class Comment < ActiveRecord::Base
  include Orderable
  include Notificationable

  belongs_to :user
  belongs_to :proposal

  belongs_to :commentable, polymorphic: true, counter_cache: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votings, as: :votable, dependent: :destroy
  has_many :flags, as: :flaggable, dependent: :destroy

  after_create  :after_create_callbacks
  after_destroy :update_user_rank

  paginates_per 25

  def self.find_by_parent(parent)
    where(:commentable_id => parent.id, :commentable_type => parent.class.name)
  end

  private

  def after_create_callbacks
    update_user_rank
    # create_notification :comment_created
  end

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
