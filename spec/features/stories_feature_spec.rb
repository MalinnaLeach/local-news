require 'rails_helper'

feature 'stories' do
  context 'no stories have been added' do
    scenario 'should display a prompt to add a story' do
      visit '/stories'
      expect(page).to have_content 'No stories yet'
      expect(page).to have_link 'Add a story'
    end
  end
end
