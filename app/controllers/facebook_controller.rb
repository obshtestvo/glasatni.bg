class FacebookController < ApplicationController

  layout "facebook"

  def home
  end

  def proposal
    @proposal = Proposal.find(params[:id])
  end

end