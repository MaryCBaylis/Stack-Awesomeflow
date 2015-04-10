class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @comment = Comment.new(
      commentable_type: params[:commentable_type],
      commentable_id: params[:commentable_id])
  end

  def create
    @comment = Comment.new(
      commentable_type: params[:comment][:commentable_type],
      commentable_id:   params[:comment][:commentable_id].to_i,
      body:             params[:comment][:body],
      user:             current_user)
    @comment.save
    redirect_to root_path
  end
end
