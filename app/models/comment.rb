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
  after_destroy :after_destroy_callbacks

  paginates_per 25

  def self.find_by_parent(parent)
    where(commentable: parent)
  end

  def is_nested?
    self.commentable_type == "Comment"
  end

  private

  def after_create_callbacks
    update_user_rank

    if self.is_nested?

      parent_proposal = self.commentable.commentable
      parent_proposal.comments_count += 1
      parent_proposal.save!

    end

  end

  def after_destroy_callbacks
    update_user_rank
    if self.is_nested?

      parent_proposal = self.commentable.commentable
      parent_proposal.comments_count -= 1
      parent_proposal.save!

    end
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
