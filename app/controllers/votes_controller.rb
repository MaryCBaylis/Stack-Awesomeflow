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
      vote = Vote.create(value: params[:value].to_i, user: current_user, votable_type: params[:votable_type], votable_id: params[:votable_id])
    end

    case params[:votable_type]
    when 'Question'
      render partial: 'shared/question_votes', layout: false, locals: { question: @question }
    when 'Answer'
      render partial: 'shared/answer_votes', layout: false, locals: { question: @question, answer: Answer.find_by(id: params[:votable_id]) }
    when 'Comment'
      render partial: 'shared/comment_votes', layout: false, locals: { question: @question, comment: Comment.find_by(id: params[:votable_id]) }
    end
  end

  private

  def vote_exists(params)
    Vote.find_by(votable_type: params[:votable_type], votable_id: params[:votable_id], user: current_user)
  end
end