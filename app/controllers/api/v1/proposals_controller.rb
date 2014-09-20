module Api
  module V1
    class ProposalsController < ApplicationController
      respond_to :json

      def index
        order = proposal_params[:order]
        theme_id = proposal_params[:theme_id]
        user_id = proposal_params[:user_id]

        query = Proposal.all
        query = query.where(theme_id: theme_id) if theme_id.present? and theme_id != "all"
        query = query.where(user_id: user_id) if user_id.present?
        query = query.custom_order(order) if order.present?
        query = query.includes(:user).includes(:theme)

        @proposals = query.page(proposal_params[:page])
      end

      def show
        @proposal = Proposal.find(proposal_params[:id])
      end

      def count
        theme_id = proposal_params[:theme_id]
        if theme_id == "all" or theme_id.blank?
          count = Proposal.count
        else
          count = Proposal.where(theme_id: theme_id).count
        end
        render json: count
      end

      private
      def proposal_params
        params.slice(:id, :order, :page, :theme_id, :user_id)
      end
    end
  end
end
