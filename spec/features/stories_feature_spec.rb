require 'rails_helper'

feature 'stories' do
  context 'stories have been added' do
    scenario 'should display a prompt to add a story' do
      visit '/stories'
      expect(page).to have_content 'Tube strike'
      expect(page).not_to have_content 'No stories yet'
    end
  end
end
