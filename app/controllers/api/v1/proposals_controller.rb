module Api
  module V1
    class ProposalsController < ApplicationController
      before_action :set_proposal, only: [:show, :edit, :update, :destroy]
      respond_to :json

      def index
        order = proposal_params[:order]
        theme_name = proposal_params[:theme_name]
        user_id = proposal_params[:user_id]

        query = Proposal.all
        if theme_name.present? and theme_name != "all"
          query = query.joins(:theme).where(themes: { name: Theme.en_names[theme_name.to_sym] })
        end
        query = query.where(user_id: user_id) if user_id.present?
        query = query.custom_order(order) if order.present?
        query = query.includes(:user).includes(:theme)

        @beforePaged = query
        @page = proposal_params[:page].present? ? proposal_params[:page].to_i : 1
        @proposals = query.page(proposal_params[:page])
      end

      def show
        @proposal = Proposal.find(proposal_params[:id])
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

      private
      def set_proposal
        @proposal = Proposal.find(params[:id])
      end

      def proposal_params
        params.permit(:id, :order, :page, :theme_name, :user_id, :title, :content, :theme_id)
      end
    end
  end
end
