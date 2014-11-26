module Api
  module V1
    class ProposalsController < ApplicationController
      before_action :set_proposal, only: [:show, :update, :destroy, :approve]
      authorize_resource only: [:create, :update, :destroy, :approve]
      respond_to :json

      def index
        # assign some variables
        order = proposal_params[:order]
        theme_name = proposal_params[:theme]
        user_id = proposal_params[:user_id]
        voter_id = proposal_params[:voter_id]

        # the query starts here
        query = Proposal.all

        # filter by theme if present
        if theme_name.present? and theme_name != "all"
          query = query.joins(:theme).where(themes: { name: Theme.en_names[theme_name.to_sym] })
        end

        # this is needed for user's profile page
        # if 'user_id' is present, show only user's proposals
        query = query.where(user_id: user_id) if user_id.present?

        # apply filters if present
        query = query.custom_order(order) if order.present?

        # lazy load associated authors, themes and the theme's moderator accounts
        query = query.includes(:user).includes(theme: :moderator)

        # if a registered user is making the query:
        # 1. see how he/she voted
        # 2. see if mod and display unapproved proposals if so
        if voter_id.present?
          user = User.find(voter_id) if voter_id.present?
          query = query.approved unless user.moderator?
          @votings = Voting.where(user: user, votable: query).pluck(:votable_id, :value).to_h
        else
          query = query.approved
          @votings = []
        end

        # some meta data about the result of the query, needed for UI purposes
        @proposals_count = query.count
        @page = proposal_params[:page].present? ? proposal_params[:page].to_i : 1
        @proposals = query.page(proposal_params[:page])
      end

      def show
        @proposal = Proposal.find(proposal_params[:id])
        @voter_id = proposal_params[:voter_id]
      end

      def create
        @proposal = Proposal.new(proposal_params)
        @proposal.user = current_user

        if @proposal.save
          render :show
        else
          render json: @proposal.errors, status: :unprocessable_entity
        end
      end

      def update
        if @proposal.update(proposal_params)
          render :show
        else
          render json: @proposal.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @proposal.destroy
        render json: { success: true }
      end

      def approve
        @proposal.approved = proposal_params[:approved]
        @proposal.save
        render :show
      end

      private
      def set_proposal
        @proposal = Proposal.find(params[:id])
      end

      def proposal_params
        params.permit(:id, :order, :page, :theme, :user_id, :title, :content, :theme_id, :voter_id, :approved)
      end
    end
  end
end
