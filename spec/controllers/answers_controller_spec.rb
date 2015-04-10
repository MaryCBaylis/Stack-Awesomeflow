require 'rails_helper'

describe AnswersController do
  let!(:user)     { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}
  let!(:answer)   { Answer.create!(question: question, body: "this is the answer body", user: user)}

  before do
    sign_in user
  end

  describe "GET new" do
    it "assigns an answer as @answer" do 
      get :new, { question_id: question.id }
      expect(assigns(:answer)).to be_a(Answer)
      expect(assigns(:question)).to be_a(Question)
    end
  end

  describe "POST create" do
    it "creates a new answer when valid params are passed" do
      expect {
        post :create, { answer: { body: answer.body }, question_id: question.id }
      }.to change(Answer, :count).by(1)
    end
  end
  describe "PUT #update" do
    it "should let update your answer" do
      put :update, { answer: { body: "this is the new body" }, id: answer.id, question_id: question.id }
      expect(assigns(:answer).body).to eq("this is the new body")
    end

    it "should not let you update the answer if you are not signed in" do
      sign_out user 
      put :update, { answer: { body: "this is the new body" }, id: answer.id, question_id: question.id }
      expect(Answer.find_by(id: answer.id)).to eq(answer)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested question" do 
      delete :destroy, { id: answer.id, question_id: question.id }
      expect(Answer.find_by(id: answer.id)).to be nil
      # expect(assigns(:answer)).to eq(question)
    end

    it "only lets you delete an answer if you are signed in" do
      sign_out user 
      delete :destroy, { id: answer.id, question_id: question.id }
      expect(Answer.find_by(id: answer.id)).to eq(answer)
    end
  end
end
