class Answer < ActiveRecord::Base
  include Votable
  
  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
  has_many :responses, as: :post, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true
  validates :question, presence: true

end