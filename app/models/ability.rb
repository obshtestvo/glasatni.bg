class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.persisted?
      can :vote, [Proposal, Comment]
      can :create, [Proposal, Comment]
      can :update, Proposal, user_id: user.id
      can :update, Flag
    end

  end
end
