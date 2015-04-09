class AnswersController < ApplicationController

  def new
    @answer = Answer.new
    @question = Question.find_by(id: params[:question_id])
  end

  def create
    user = User.find_by(id: current_user.id)
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new(question: @question, body: params[:answer][:body], user: user)
    puts params[:body]
    if (@answer.save)
      redirect_to question_path(@question)
    else
      render 'new'
    end
  end

end