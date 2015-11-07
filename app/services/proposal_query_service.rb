class ProposalQueryService
  def initialize(proposal_params, archived: false)
    @archived = archived
    @order = proposal_params[:order]
    @theme_name = proposal_params[:theme]
    @user_id = proposal_params[:user_id]
    @voter_id = proposal_params[:voter_id]
    @page = proposal_params[:page]
  end

  def construct_query
    @query = Proposal.all

    filter_by_theme if @theme_name.present? && @theme_name != "all"
    filter_by_user_id if @user_id.present?
    apply_ordering if @order.present?
    apply_archived
    apply_lazyloading
    apply_voter_specific

    @query
  end

  def page
    if @page.present?
      @page.to_i
    else
      1
    end
  end

  def proposals
    @query.page(page)
  end

  private

  def filter_by_theme
    @query = @query
      .joins(:theme)
      .where(themes: { name: Theme.en_names[@theme_name.to_sym] })
  end

  # this is needed for user's profile page
  def filter_by_user_id
    @query = @query.where(user_id: @user_id)
  end

  def apply_ordering
    @query = @query.custom_order(@order)
  end

  # lazy load associated authors, themes and the theme's moderator accounts
  def apply_lazyloading
    @query = @query.includes(:user).includes(theme: :moderator)
  end

  # if a registered user is making the query:
  # 1. see how he/she voted
  # 2. see if mod and display unapproved proposals if so
  def apply_voter_specific
    if @voter_id.present?
      user = User.find(@voter_id) if @voter_id.present?
      @query = @query.approved unless user.moderator?
      @votings = Voting.where(user: user, votable: @query).pluck(:votable_id, :value).to_h
    else
      @query = @query.approved
      @votings = []
    end
  end

  def apply_archived
    @query = @query.joins(:theme).where(themes: { archived: @archived })
  end

end
