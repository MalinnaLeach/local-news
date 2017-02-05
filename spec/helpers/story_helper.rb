
def login_as_bob
  visit '/users/sign_in'
  fill_in "user[login]", with: 'bob'
  fill_in "user[password]", with: '12345678'
  click_button 'Log in'
end

def input_a_story
  visit '/stories'
  click_link 'Add a story'
  fill_in 'Headline', with: 'Tube strike'
  fill_in 'Details', with: 'Large queues at the station'
  click_button 'Publish'
end

def edit_tube_story
  visit '/stories'
  click_link 'Tube strike'
  click_link 'Edit Story'
  fill_in 'Headline', with: "Leyton station closed"
  click_button 'Update Story'
end
