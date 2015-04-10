class Question < ActiveRecord::Base
  include Votable 
  
  belongs_to :user, inverse_of: :questions
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5}
  validates :body, presence: true
  validates :user, presence: true

  def get_answers
    best = [Answer.find_by(id: get_best_answer_id)].compact
    best | self.answers_by_vote
  end

  def get_best_answer_id
    if id = self.answers.find_by(is_best: true)
      id
    else
      0
    end
  end

  def mark_best(answer_id)
    self.answers.update_all(is_best: false)
    Answer.find_by(id: answer_id).update(is_best: true)
  end

  def answers_by_vote
    self.answers.sort_by {|a| a.net_vote}.reverse
  end

  def self.sort_by_popularity
    self.all.sort_by{ |q| q.net_vote }.reverse
  end
end
