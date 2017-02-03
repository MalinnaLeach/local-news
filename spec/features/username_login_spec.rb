require 'rails_helper'

feature 'logging in with username' do

  before do
    user = User.create(username: 'bob', email: 'bob@gmail.com', password: '12345678', password_confirmation: '12345678')
  end

  scenario 'user can log in with their username' do
    visit '/users/sign_in'
    fill_in "user[login]", with: 'bob'
    fill_in "user[password]", with: '12345678'
    click_button 'Log in'
    expect(page).to have_content 'bob'
  end

end
