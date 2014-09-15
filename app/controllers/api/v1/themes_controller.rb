module Api
  module V1
    class ThemesController < ApplicationController

      def proposals_count
        count = Proposal.where(theme_id: theme_params[:theme_id]).count
        render json: { count: count }
      end

      private
      def theme_params
        params.slice(:theme_id)
      end
    end
  end
end

