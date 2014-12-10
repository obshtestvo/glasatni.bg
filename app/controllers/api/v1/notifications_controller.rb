module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :set_proposal, only: [:show, :update, :destroy, :approve]
      authorize_resource only: [:create, :update, :destroy, :approve]
      respond_to :json

      def index
        query = Notification.includes(:proposal, :user).where(recipient: current_user)

        # some meta data about the result of the query, needed for UI purposes
        @notifications_count = query.count
        @page = notification_params[:page].present? ? notification_params[:page].to_i : 1
        @notifications = query.page(notification_params[:page])
      end

      def check_new
        result = Notification.exists?
        render result
      end

      private
      def notification_params
        params.permit(:page)
      end

    end
  end
end
