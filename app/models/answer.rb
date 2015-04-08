class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :responses, as: :post, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true
  validates :user_id, presence: true
  validates :question_id, presence: true
end