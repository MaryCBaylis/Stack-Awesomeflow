require 'rails_helper'

feature "User viewing answers" do
    let(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}
  let!(:answer) { Answer.create!(body: "This is the body", user: user, question: question)}


  before do
    visit new_user_session_path
    find('#user_email').set(user.email)
    find('#user_password').set(user.password)
    click_button('Log in')
  end

  scenario "User can view answers while logged out" do
    click_link("Log Out") 
    visit question_path(question)
    expect(page).to have_content(answer.body)
  end

  scenario "User cant add answer unless loged in" do 
    click_link("Log Out") 
    visit new_question_answer_path(question)
    expect(page).to have_no_content(answer.body)
  end

  scenario "User cant edit answer unless loged in" do 
    click_link("Log Out") 
    visit "/questions/#{question.id}/answers/#{answer.id}/edit"
    expect(page).to have_no_content(answer.body)
  end

  scenario "User can view their answer on question page once added" do
    
  end

  scenario "User can edit their answer" do
  end
end