class VotesController < ApplicationController

  before_action :authenticate_user!

  def new
    @question = Question.find_by(id: params[:question_id])
    vote = Vote.new(value: params[:value].to_i, user: current_user, votable_type: params[:votable_type], votable_id: params[:votable_id])
    vote.save unless Vote.find_by(votable_type: params[:votable_type], votable_id: params[:votable_id], user: current_user)
    render 'questions/show'
  end
end