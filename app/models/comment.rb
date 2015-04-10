class Comment < ActiveRecord::Base
  include Votable
  
  belongs_to :user, inverse_of: :comments
  belongs_to :commentable, polymorphic: true, inverse_of: :comments
  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true
  validates :commentable, presence: true
end
