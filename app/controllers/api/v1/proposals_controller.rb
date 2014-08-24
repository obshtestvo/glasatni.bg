module Api
  module V1
    class ProposalsController < ApplicationController
      respond_to :json

      def index
        respond_with Proposal.all
      end

    end
  end
end
