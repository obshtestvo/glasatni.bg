module Api
  module V1
    class CommentsController < ApplicationController
      respond_to :json

      def index

        proposal_id = comment_params[:proposal_id]

        per_page = comment_params[:per_page] || 10
        page = comment_params[:page] || 0

        query = Comment.includes(:user).limit(per_page).offset(page).order(:created_at)
        query = query.where(proposal_id: proposal_id) unless proposal_id.blank?

        @comments = query

      end

      def create
      end

      private

      def comment_params
        params.slice(:proposal_id, :per_page, :page)
      end

    end
  end
end

