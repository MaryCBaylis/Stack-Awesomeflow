class Vote < ActiveRecord::Base
  belongs_to :user, inverse_of: :votes
  belongs_to :votable, polymorphic: true, inverse_of: :votes

  validates :value, presence: true, inclusion: {in: [-1, 1]} 
  validates :user, presence: true
  validates :votable, presence: true
end