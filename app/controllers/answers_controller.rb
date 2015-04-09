class AnswersController < ApplicationController

  def new
    @answer = Answer.new
    @question = Question.find_by(id: params[:question_id])
  end

  def create
    user = User.find_by(id: current_user.id)
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.new(question: @question, body: params[:answer][:body], user: user)
    if (@answer.save)
      redirect_to question_path(@question)
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:question_id])
    @answer = Answer.find_by(id: params[:id])
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
    @question = Question.find_by(id: params[:question_id]
      )
    @answer = Answer.find_by(id: params[:id])
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to questions_path, alert: "You successfully deleted your answer."
    else
      redirect_to questions_path, alert: "That was bad, and you should feel bad.  You're bad."
    end
  end

  private

  def answer_params
    params.require[:answer].permit(:body)
  end

end