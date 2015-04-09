require 'rails_helper'

describe QuestionsController do
  let!(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}

  before do
    sign_in user
  end

  describe "GET new" do
    it "assigns a question as @question" do 
      get :new
      expect(assigns(:question)).to be_a(Question)
    end
  end

  describe "POST create" do
    it "creates a new question when valid params are passed" do
      expect {
        post :create, { question: {title: "this is a title", body: "this is the body", user: user} }
      }.to change(Question, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested question" do 
      delete :destroy, { id: question.to_param }
      expect(assigns(:question)).to eq(question)
    end

    it "only lets you delete qustion if you are signed in" do
      sign_out user 
      delete :destroy, { id: question.to_param }
      expect(assigns(:question)).to be_nil
    end

  end
end
