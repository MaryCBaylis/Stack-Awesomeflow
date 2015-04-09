class AnswersController < ApplicationController

  before_action :set_question
  before_action :set_answer, only: [:edit, :update, :destroy]

  def new
    @answer = Answer.new
  end

  def create
    user = User.find_by(id: current_user.id)
    @answer = Answer.new(question: @question, body: params[:answer][:body], user: user)
    if (@answer.save)
      redirect_to question_path(@question)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @answer.user_id == current_user.id
      if @answer.update(body: params[:answer][:body])
        redirect_to question_path(@question)
      else
        render 'edit'
      end
    else
      redirect_to questions_path, alert: "That was bad, and you should feel bad.  You're bad."
    end
  end

  def destroy
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to questions_path, alert: "You successfully deleted your answer."
    else
      redirect_to questions_path, alert: "That was bad, and you should feel bad.  You're bad."
    end
  end

  protected

  def set_question
    @question = Question.find_by(id: params[:question_id])
  end

  def set_answer
    @answer = Answer.find_by(id: params[:id])
  end

  private

  def answer_params
    params.require[:answer].permit(:body)
  end

end