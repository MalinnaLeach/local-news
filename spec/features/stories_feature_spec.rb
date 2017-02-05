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
      login_as_bob
      Story.create(headline: 'Tube strike', details: 'Large queues at the station', area: Area.where(:name => 'Leyton').first)
      visit '/stories'
      expect(page).to have_content 'Tube strike'
      expect(page).not_to have_content 'No stories yet'
    end
  end

  context 'creating stories' do
    scenario 'prompts user to fill out a form, then displays the new story' do
      login_as_bob
      input_a_story
      expect(page).to have_content 'Tube strike'
      expect(current_path).to eq '/stories'
    end
  end

  context 'viewing full stories' do

    let!(:tube){ Story.create(headline: 'Tube strike', details: 'Large queues at the station', area: Area.where(:name => 'Leyton').first) }

    scenario 'lets a user view a story' do
      login_as_bob
      visit '/stories'
      click_link 'Tube strike'
      expect(page).to have_content 'Tube strike'
      expect(current_path).to eq "/stories/#{tube.id}"
    end
  end

  context 'editing a story' do

    let!(:tube){ Story.create(headline: 'Tube strike', details: 'Large queues at the station', area: Area.where(:name => 'Leyton').first) }

    scenario 'lets a user edit their story' do
      login_as_bob
      edit_tube_story
      expect(page).to have_content "Leyton station closed"
      expect(current_path).to eq "/stories/#{tube.id}"
    end
  end

  context 'deleting a story' do

    let!(:tube){ Story.create(headline: 'Tube strike', details: 'Large queues at the station', area: Area.where(:name => 'Leyton').first) }

    scenario 'lets a user delete their story' do
      login_as_bob
      visit '/stories'
      click_link 'Tube strike'
      click_link 'Delete Story'
      expect(page).not_to have_content "Tube strike"
      expect(current_path).to eq '/stories'
    end
  end

end
