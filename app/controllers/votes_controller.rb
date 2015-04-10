class VotesController < ApplicationController

  before_action :authenticate_user!

  def new
    @question = Question.find_by(id: params[:question_id])
    if vote = vote_exists(params)
      if vote.value == params[:value].to_i
        vote.destroy
      else
        vote.update(value: params[:value])
      end
    else
      Vote.create(value: params[:value].to_i, user: current_user, votable_type: params[:votable_type], votable_id: params[:votable_id])
    end

    redirect_to question_path(@question)
  end

  private

  def vote_exists(params)
    Vote.find_by(votable_type: params[:votable_type], votable_id: params[:votable_id], user: current_user)
  end
end