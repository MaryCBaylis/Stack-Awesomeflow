require 'rails_helper'

describe CommentsController do
  let!(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}
  let!(:comment) { Comment.create!(body: "this is a comment", user: user, commentable_type: "Question", commentable_id: question.id)}


  before do
    sign_in user
  end

  describe "GET new" do
    it "assigns a comment as @comment" do 
      get :new
      expect(assigns(:comment)).to be_a(Comment)
    end
  end  
end