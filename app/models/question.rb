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

  def self.sort_by_trending
    self.all.sort_by{ |q| 
      q.count_recent_votes + q.count_recent_answers + q.count_recent_comments
    }.reverse[0..4]
  end


  def count_recent_votes
    Vote.where(created_at: 1.week.ago..Time.now, votable_type: "Question", votable_id: self.id).count
  end

  def count_recent_comments
    count = 0
    Answer.all.each do |a|
      if a.question_id == self.id
        a.comments.each do |c|
          if a.created_at >= Time.now
            count+=1
          end
        end 
      end
    end
    Comment.where(created_at: 1.week.ago..Time.now, commentable_type: "Question", commentable_id: self.id).count + count
  end

  def count_recent_answers
    Answer.where(created_at: 1.week.ago..Time.now, question_id: self.id).count
  end
end