class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, presence: true, inclusion: {in: [-1, 1]} 
  validates :user_id, presence: true
  validates :votable_id, presence: true
end