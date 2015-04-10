class Response < ActiveRecord::Base
  include Votable
  
  belongs_to :user, inverse_of: :responses
  belongs_to :post, polymorphic: true, inverse_of: :responses
  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true
  validates :post, presence: true
end