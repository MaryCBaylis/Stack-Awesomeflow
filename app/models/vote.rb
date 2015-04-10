class Vote < ActiveRecord::Base
  belongs_to :user, inverse_of: :votes
  belongs_to :votable, polymorphic: true, inverse_of: :votes

  validates :value, presence: true, inclusion: {in: [-1, 1]} 
  validates :user, presence: true
  validates :votable, presence: true

  def self.find_votable(type, id)
    if type == "Question"
      Question.find_by(id: id)
    else if type == "Answer"
      Answer.find_by(id: id)
    else if type == "Comment"
      Response.find_by(id: id)
    end
  end
end