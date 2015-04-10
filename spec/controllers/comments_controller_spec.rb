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

  describe "POST create" do
    it "creates a new comment when valid params are passed" do
      expect {
        post :create, { comment: { body: "this is a comment", user: user, commentable_type: "Question", commentable_id: question.id} }
      }.to change(Comment, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested comment" do 
      delete :destroy, { id: comment.to_param }
      expect(assigns(:comment)).to eq(comment)
    end

    it "only lets you delete comment if you are signed in" do
      sign_out user 
      delete :destroy, { id: comment.to_param }
      expect(assigns(:comment)).to be_nil
    end
  end
end