class User < ActiveRecord::Base

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def get_recent_questions(id)
    questions = Question.where(user_id: id)
    questions.sort_by{ |q| q.created_at }.reverse
  end

  def get_recent_answers(id)
    answers = Answer.where(user: id)
    answers.sort_by{ |a| a.created_at }.reverse
  end
end
