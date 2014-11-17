class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.moderator?
      can :manage, :all
    elsif user.persisted?
      can :vote, [Proposal, Comment]
      can :create, [Proposal, Comment]
      can :update, Proposal, user_id: user.id
      can :destroy, [Comment, Proposal], user_id: user.id
    end

  end
end
