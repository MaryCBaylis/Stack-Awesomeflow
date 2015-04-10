class QuestionsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy, :mark_best]

  def index
    @questions = Question.order created_at: :desc
  end

  def show
    unless @question
      redirect_to questions_path, alert: "That question does not seem to exist"
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))
    if @question.save
      redirect_to question_path(@question)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if (@question.user_id == current_user.id)
      if @question && @question.update(question_params)
        redirect_to question_path(@question)
      else
        render "edit"
      end
    else
      redirect_to questions_path, alert: "That was bad, and you should feel bad.  You're bad."
    end
  end

  def destroy
    if (@question.user_id == current_user.id)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to questions_path, alert: "That was bad, and you should feel bad.  You're bad."
    end
  end

  def mark_best
    @question.mark_best(params[:answer_id])
    redirect_to question_path(@question)
  end

  def recent
    redirect_to questions_path
  end

  def popular
    @questions = Question.sort_by_popularity
    render 'index'
  end

  def trending

  end

  protected

  def set_question
    @question = Question.find_by(id: params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
