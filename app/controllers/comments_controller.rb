class CommentsController < ApplicationController
  # before_action :authenticate_user!
  
  def new
    @comment = Comment.new(
      commentable_type: params[:commentable_type],
      commentable_id: params[:commentable_id])
  end
end
