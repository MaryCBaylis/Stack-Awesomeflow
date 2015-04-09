require 'rails_helper'

describe QuestionsController do
  let!(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}

  describe "GET new" do
    it "assigns a question as @question" do 
      get :new
      expect(assigns(:question)).to be_a(Question)
    end
  end

  describe "POST create" do
    it "creates a new question when valid params are passed" do

      user = User.find_by(email: "bob@boby.com")
      session[:user_id] = user.id
      expect {
        post :create, { question: {title: "this is a title", body: "this is the body", user: user} }
      }.to change(Question, :count).by(1)
    end


  end

end