class QuestionsController < ApplicationController

	def new
		@question = Question.new
	end

	def create
		params[:question][:user_id] = current_user.id
		@question = Question.new(question_params)

		if @question.save
			redirect question_path(@question)
		else
			render "new"
		end
	end

	private

	def question_params
		params.require(:question).permit(:title, :body, :user_id)
	end
end