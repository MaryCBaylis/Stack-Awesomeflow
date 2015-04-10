require 'rails_helper'

describe Comment do
   let!(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }

  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}  

  let!(:comment_2) { Comment.create!(body: "this is the bodddyyyyydsf", user: user, commentable_type: Question, commentable_id: question.id)}  

  let!(:comment) { Comment.create!(body: "this is the bodddyyyyy", user: user, commentable_type: Question, commentable_id: question.id)}  

  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  it "should should create a new comment" do
    expect(comment).to eq(Comment.last)

  end

  it "A question could have many comments" do
    expect(question.comments.count).to eq(2)
  end

  it "should update the comment" do
    comment.update(body: "boomboom")
    expect(Comment.last.body).to eq("boomboom")
  end

  it "should delete the comment" do
    expect{ comment.destroy }.to change(Comment, :count).by(-1) 
  end

end
