module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def show
        @user = User.find(params[:id])
      end

    end
  end
end


