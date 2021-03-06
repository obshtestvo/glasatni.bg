class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :json

  def after_sign_in_path_for resource
    "/proposals"
  end

  def home
  end

  def rank
    @rank = application_params[:rank]
    if @rank.in? User.comments_ranks.keys
      @users = User.where(comments_rank: User.comments_ranks[@rank])
    elsif @rank.in? User.proposals_ranks.keys
      @users = User.where(proposals_rank: User.proposals_ranks[@rank])
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def vote
    klass_str = application_params[:votable]

    if not klass_str.in? ["comment", "proposal"]
      render nothing: true, status: :unprocessable_entity
    elsif user_signed_in?
      direction = params[:vote]

      klass = application_params[:votable].titleize.constantize
      votable = klass.find(application_params[:id])
      author = votable.user

      voting = Voting.find_or_initialize_by({
        user: current_user,
        votable: votable
      })

      # voting is initialized
      if voting.value.nil?

        voting.value = Voting.values[direction.to_sym]
        voting.save

        direction == "up" ? votable.up += 1 : votable.down += 1
        author.reputation += direction == "up" ? 1 : -1

      # voting is already created and user REMOVED her/his vote
      elsif voting.value == Voting.values[direction.to_sym]

        voting.destroy

        direction == "up" ? votable.up -= 1 : votable.down -= 1
        author.reputation += direction == "up" ? -1 : 1

      # voting is already created and user CHANGED her/his vote
      elsif voting.value != Voting.values[direction.to_sym]

        voting.value = Voting.values[direction.to_sym]
        voting.save

        if direction == "up"
          votable.up += 1
          votable.down -= 1
        else
          votable.up -= 1
          votable.down += 1
        end

        author.reputation += direction == "up" ? 2 : -2

      end

      votable.hotness = votable.up - votable.down
      votable.save
      author.save

      render json: { hotness: votable.hotness, up: votable.up, down: votable.down }
    else
      render nothing: true, status: :unauthorized
    end

  end

  def flag
    if application_params[:flaggable_type] == "comment"
      flaggable = Comment.find(application_params[:flaggable_id])
    else
      flaggable = Proposal.find(application_params[:flaggable_id])
    end

    flag = Flag.find_or_initialize_by({
      user: current_user,
      flaggable: flaggable
    })

    flag.update(reason: Flag.reasons[application_params[:reason]])

    render json: { success: true }
  end

  def me
    render json: current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { :status => :error, :message => "You don't have permission to #{exception.action} #{exception.subject.class.to_s.pluralize}" }, :status => 403
  end

  protected

  def application_params
    params.permit(:id, :votable, :flaggable_type, :flaggable_id, :reason, :rank)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :bio, :subscribed) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :bio, :subscribed) }
  end

end
