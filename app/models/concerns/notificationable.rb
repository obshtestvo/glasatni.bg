module Notificationable
  extend ActiveSupport::Concern

  def create_notification action

    case action
      when :comment_created then proposal = self.commentable; recipient = self.commentable.theme.moderator
      when :proposal_created then proposal = self; recipient = self.theme.moderator
    end

    Notification.create
      {
        user: self.user,
        proposal: proposal,
        recipient: recipient,
        action: Notification.actions[action]
      }

  end

end
