class QuestionsController < ApplicationController
  def index
    @questions = Question.order created_at: :desc
  end

  def show
    @question = Question.find_by id: params[:id]

    unless @question
      redirect_to questions_path, alert: "That question does not seem to exist"
    end
  end

  def new
    @question = Question.new
  end

  def create
    params[:question][:user_id] = current_user.id
    @question = Question.new(question_params)

    if @question.save
      redirect_to question_path(@question)
    else
      render "new"
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find_by(id: params[:id])
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
    @question = Question.find_by(id: params[:id])
    if (@question.user_id == current_user.id)
	    @question.destroy
	    redirect_to questions_path
	  else
	  	redirect_to questions_path, alert: "That was bad, and you should feel bad.  You're bad."
	  end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end
end
