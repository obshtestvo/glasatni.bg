module Api
  module V1
    class ProposalsController < ApplicationController
      respond_to :json

      def index
        order = proposals_params[:order]

        query = Proposal.all
        query = query.custom_order(order) if order.present?

        @proposals = query
      end

      private
      def proposals_params
        params.slice(:order)
      end

    end
  end
end
