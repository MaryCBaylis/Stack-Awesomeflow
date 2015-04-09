class QuestionsController < ApplicationController

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
		if @question.update(question_params)
			redirect_to question_path(@question)
		else
			render "edit"
		end
	end

	private

	def question_params
		params.require(:question).permit(:title, :body, :user_id)
	end
end