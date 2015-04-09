require 'rails_helper'



describe Question do
  let!(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}
 
  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  it "should should create a new question" do
    expect(question).to eq(Question.last)
  end

  it "should update the question" do
    question.update(body: "boomboom")
    expect(Question.last.body).to eq("boomboom")
  end

  it "should delete the question" do
    expect{ question.destroy }.to change(Question, :count).by(-1) 
  end
end 