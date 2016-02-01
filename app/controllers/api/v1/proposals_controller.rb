module Api
  module V1
    class ProposalsController < ApplicationController
      before_action :set_proposal, only: [:show, :update, :destroy, :approve]
      authorize_resource only: [:create, :update, :destroy, :approve]
      respond_to :json

      def index
        pqs = ProposalQueryService.new(proposal_params)
        @query = pqs.construct_query
        @votings = pqs.votings

        # some meta data about the result of the query, needed for UI purposes
        @proposals_count = @query.count
        @page = pqs.page
        @proposals = pqs.proposals
      end

      def archived
        pqs = ProposalQueryService.new(proposal_params, archived: true)
        @query = pqs.construct_query

        # some meta data about the result of the query, needed for UI purposes
        @proposals_count = @query.count
        @page = pqs.page
        @proposals = pqs.proposals

        render :index
      end

      def show
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

        # create/delete 'approved' status
        if @proposal.approved == true
          Status.create(kind: 0, proposal: @proposal)
        else
          Status.find_by(kind: 0, proposal: @proposal).delete
        end

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
