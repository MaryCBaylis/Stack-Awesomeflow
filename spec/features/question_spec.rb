require 'rails_helper'


feature "User viewing a question page" do
  let(:user) { User.create!(email: "bob@boby.com", password: "12341234")  }
  let!(:question) { Question.create!(title: "titletitle", body: "this is the body", user: user)}

  before do
    visit new_user_session_path
    find('#user_email').set(user.email)
    find('#user_password').set(user.password)
    click_button('Log in')
  end

  scenario "when user views a question" do
    visit question_path(question)
    expect(page).to have_content(question.title)
  end

  scenario "When user tries to update their question, text field are prefilled" do
    visit edit_question_path(question)
    expect(page.find("textarea").text).to eq(question.body)

  end

  scenario "When user updates their question, it updates it on the question index page too" do
    visit edit_question_path(question)
    find('#question_title').set("this is the new title")
    click_button("Update Question")
    expect(page).to have_content("this is the new title")

  end

  scenario "when user tries to delete their question" do
    visit edit_question_path(question)
    click_button("Delete")
    expect(page).to have_no_content(question.title) 
  end

  scenario "User redirected to login page if not authorized to edit question" do
    click_link("Log Out") 
    visit edit_question_path(question)
    expect(page).to have_no_content(question.title)
  end
end