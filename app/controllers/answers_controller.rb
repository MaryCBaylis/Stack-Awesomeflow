class AnswersController < ApplicationController

  def new
    @answer = Answer.new
    @question = Question.find_by(id: params[:question_id])
  end

  def create
    question = Question.find_by(id: params[:question_id])
    answer = Answer.new(question: question, body: params[:body])
    if (answer.save)
      redirect question_path(question)
    else
      render 'new'
    end
  end

end