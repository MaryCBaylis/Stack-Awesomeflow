require 'rails_helper'


describe User do
  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  it "should create a new user" do
    user = User.create! email: "faker@faker.com", password: "asdfasdf", password_confirmation: "asdfasdf"
    expect(user).to eq(User.last)
  end
end
