require 'rails_helper'

feature 'stories' do

  before do
    leyton = Area.create(name: 'Leyton')
    user = User.create(username: 'bob', email: 'bob@gmail.com', area: leyton, password: '12345678', password_confirmation: '12345678')
  end

  context 'where no stories have been added' do
    scenario 'should display a prompt to add a story' do
      visit '/stories'
      expect(page).to have_content 'No stories yet'
      expect(page).to have_link 'Add a story'
    end
  end

  context 'where stories have been added' do

    scenario 'should display a story' do
      visit '/users/sign_in'
      fill_in "user[login]", with: 'bob'
      fill_in "user[password]", with: '12345678'
      click_button 'Log in'
      Story.create(headline: 'Tube strike', details: 'Large queues at the station', area: Area.where(:name => 'Leyton').first)
      visit '/stories'
      expect(page).to have_content 'Tube strike'
      expect(page).not_to have_content 'No stories yet'
    end
  end

  context 'creating stories' do

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/users/sign_in'
      fill_in "user[login]", with: 'bob'
      fill_in "user[password]", with: '12345678'
      click_button 'Log in'
      visit '/stories'
      click_link 'Add a story'
      fill_in 'Headline', with: 'Tube strike'
      fill_in 'Details', with: 'Large queues at the station'
      click_button 'Publish'
      expect(page).to have_content 'Tube strike'
      expect(current_path).to eq '/stories'
    end
  end

  context 'viewing full stories' do

    let!(:tube){ Story.create(headline: 'Tube strike', details: 'Large queues at the station', area: Area.where(:name => 'Leyton').first) }

    scenario 'lets a user view a restaurant' do
      visit '/users/sign_in'
      fill_in "user[login]", with: 'bob'
      fill_in "user[password]", with: '12345678'
      click_button 'Log in'
      visit '/stories'
      click_link 'Tube strike'
      expect(page).to have_content 'Tube strike'
      expect(current_path).to eq "/stories/#{tube.id}"
    end
  end

end
