class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    question = Question.find_by(id: params[:question_id])
    votable = Vote.find_votable(params[:votable_type], params[:votable_id])
    vote = Vote.new(value: params[:vote_value], user: current_user, votable: votable)
    if (vote.save && !Vote.find_by(question: question, user: current_user))
      render show_question_path(question)
    end
  end
end