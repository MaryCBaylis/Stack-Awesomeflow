class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, polymorphic: true
  has_many :votes, as: :votable, dependent: :destroy
end