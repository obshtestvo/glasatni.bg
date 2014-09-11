module Api
  module V1
    class ProposalsController < ApplicationController
      respond_to :json

      def index
        @proposals = Proposal.all
      end

    end
  end
end
