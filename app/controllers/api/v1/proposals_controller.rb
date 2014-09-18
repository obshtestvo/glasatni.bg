module Api
  module V1
    class ProposalsController < ApplicationController
      respond_to :json

      def index
        order = proposal_params[:order]
        theme_id = proposal_params[:theme_id]

        query = Proposal.all
        query = query.where(theme_id: theme_id) if theme_id.present?
        query = query.custom_order(order) if order.present?
        query = query.includes(:user)

        @proposals = query.page(proposal_params[:page])
      end

      def show
        @proposal = Proposal.find(proposal_params[:id])
      end

      private
      def proposal_params
        params.slice(:id, :order, :page, :theme_id)
      end
    end
  end
end
