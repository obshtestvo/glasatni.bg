module Api
  module V1
    class ThemesController < ApplicationController
      respond_to :json

      def index
        @themes = Theme.includes(:moderator)
      end

      def show
        @theme = Theme.find(params[:id])
      end

    end
  end
end

