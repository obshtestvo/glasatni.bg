module Api
  module V1
    class CommentsController < ApplicationController
      respond_to :json

      def index
        proposal_id = comment_params[:proposal_id]
        order = comment_params[:order].present? ? comment_params[:order] : "relevance"

        query = Comment.includes(:user)
        query = query.where(proposal_id: proposal_id) unless proposal_id.blank?
        query = query.custom_order order

        @comments = query.page(comment_params[:page])
      end

      def show
        @comment = Comment.find(comment_params[:id])
      end

      def create
        proposal_id = comment_params[:proposal_id]
        content = comment_params[:content]

        @comment = Comment.new(proposal_id: proposal_id, user: current_user, content: content)

        if @comment.save
          render :show
        else
          render json: @badge.errors, status: :unprocessable_entity
        end

      end

      def destroy
        @comment = Comment.find(comment_params[:id])
        @comment.destroy

        head :no_content
      end

      private

      def comment_params
        params.slice(:id, :proposal_id, :per_page, :page, :content, :order)
      end

    end
  end
end

