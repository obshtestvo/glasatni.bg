module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :destroy]
      authorize_resource only: [:create, :destroy]
      respond_to :json

      def index
        commentable_type = comment_params[:commentable_type]
        user_id = comment_params[:user_id]
        @voter_id = comment_params[:voter_id]

        if commentable_type == "comment"
          commentable = Comment.find(comment_params[:commentable_id])
        elsif commentable_type == "proposal"
          commentable = Proposal.find(comment_params[:commentable_id])
        else
          # no commentable fetched, none needed
        end

        order = comment_params[:order].present? ? comment_params[:order] : "relevance"

        query = Comment.includes(:user).includes(:proposal)
        query = query.where(user_id: user_id) if user_id.present?
        query = query.find_by_parent(commentable) if commentable_type.present?
        query = query.custom_order order

        @comments_count = query.count
        @page = comment_params[:page].present? ? comment_params[:page].to_i : 1
        @comments = query.page(@page)

      end

      def show
      end

      def create
        if comment_params[:commentable_type] == "comment"
          commentable = Comment.find(comment_params[:commentable_id])
        else
          commentable = Proposal.find(comment_params[:commentable_id])
        end

        content = comment_params[:content]

        @comment = Comment.new(commentable: commentable, user: current_user, content: content)

        if @comment.save
          render :show
        else
          render json: @badge.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy

        head :no_content
      end

      private

      def set_comment
        @comment = Comment.find(comment_params[:id])
      end

      def comment_params
        params.slice(:id, :commentable_id, :commentable_type, :per_page, :page, :content, :order, :user_id, :voter_id)
      end

    end
  end
end

