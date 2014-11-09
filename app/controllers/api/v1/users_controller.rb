module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def index
        rank = user_params[:rank]
        query = User.all

        if User.comments_ranks[rank]
          query = query.where(comments_rank: User.comments_ranks[rank])
        elsif User.proposals_ranks[rank]
          query = query.where(proposals_rank: User.proposals_ranks[rank])
        elsif rank.present?
          # query by unknown rank -> return empty collection
          query = query.none
        end

        @users_count = query.count
        @page = user_params[:page].present? ? user_params[:page].to_i : 1
        @users = query.page(@page)
      end

      def show
        @user = User.find(user_params[:id])
      end

      private
      def user_params
        params.permit(:id, :rank, :page)
      end

    end
  end
end


