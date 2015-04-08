class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, polymorphic: true
  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true
end