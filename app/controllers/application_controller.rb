class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def about
  end

  def admin
    @comments = Comment.all
  end

  def vote

    direction = params[:vote]

    if params[:votable] == "comment"
      votable = Comment.find(params[:id])
    else
      votable = Proposal.find(params[:id])
    end

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
        votable.up += 1;
        votable.down -= 1
      else
        votable.up -= 1;
        votable.down += 1
      end

      author.reputation += direction == "up" ? 2 : -2

    end

    votable.hotness = votable.up - votable.down
    votable.save
    author.save

    render json: votable.rating

  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    end

end
