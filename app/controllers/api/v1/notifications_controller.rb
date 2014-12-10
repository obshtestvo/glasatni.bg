module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :set_proposal, only: [:show, :update, :destroy, :approve]
      authorize_resource only: [:create, :update, :destroy, :approve]
      respond_to :json

      def index
        @notifications = Notification.includes(:proposal, :user)
      end

      def check_new
        result = Notification.exists?
        render result
      end

      private
      def notification_params
        params.permit(:api_token)
      end

    end
  end
end
