class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :responses, as: :post, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
end