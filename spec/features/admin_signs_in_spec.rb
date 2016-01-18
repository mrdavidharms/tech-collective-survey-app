require 'rails_helper'

feature 'admin signs in', %{
  As a Admin
  I want to be able to log into the app
  So I can create a survey

  Acceptance Criteria:

  - I should see a sign in form
  - If I fill it out without a valid sign in I should see an error
  - If I fill it out correctly I should be taken to the teacher survey
  } do
  let!(:admin) { FactoryGirl.create(:admin) }

  before do
    visit root_path
    click_link 'Sign In'
  end

  scenario 'an existing admin specifies a valid email, username, and password' do
    fill_in 'Name', with: admin.name
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Sign Out')

  end

  scenario 'a nonexistant email and password is supplied' do
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(page).to have_content('Invalid email or password.')
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an existing email with the wrong password is denied access' do
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'incorrect'
    click_button 'Log In'

    expect(page).to have_content('Invalid email or password.')
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated admin cannot re-sign in' do
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_admin_session_path
    expect(page).to have_content('You are already signed in.')
  end
end
