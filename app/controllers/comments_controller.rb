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

    if @comment && @comment.save
      if @comment.commentable_type == 'Question'
        redirect_to question_path(@comment.commentable)
      elsif @comment.commentable_type == 'Answer'
        redirect_to question_path(@comment.commentable.question)
      else
        redirect_to root_path, alert: "There was an error with that comment. Please contact the Administrator"
      end
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]

    if @comment.user == current_user && @comment.destroy
      if @comment.commentable_type == 'Question'
        redirect_to question_path(@comment.commentable)
      elsif @comment.commentable_type == 'Answer'
        redirect_to question_path(@comment.commentable.question)
      else
        redirect_to root_path, alert: "There was an error with that comment. Please contact the Administrator"
      end
    else
      redirect_to root_path, alert: "That's not your comment to delete."
    end
  end
end
