class ResponsesController < ApplicationController
  # before_action :authenticate_user!

  # params[:post] = {
  #   post_type: "Question",
  #   id: 5
  # }

  def new
    @response = Response.new
  end

end
