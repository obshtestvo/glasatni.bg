module Api
  module V1
    class ThemesController < ApplicationController
      respond_to :json

      def index
        @themes = Theme.all
      end

    end
  end
end

