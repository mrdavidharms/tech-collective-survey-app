require 'rails_helper'

feature 'admin signs up', %{
As an Admin
I want to be able to register with the app
So I can create surveys

Acceptance Criteria:

- I should see a sign up form
- If I fill it out incorrectly I should see an error
- If I fill it out correctly I should be taken to the admin root page
} do
  let(:admin){ FactoryGirl.create(:admin) }
  context "with email and password" do
    before do
      visit root_path
      click_link 'Sign Up'
    end

    scenario 'specify valid and required information' do

      fill_in 'Email', with: "admin@email.com"
      fill_in "Name", with: admin.name
      fill_in 'Password', with: admin.password
      fill_in 'Password confirmation', with: admin.password
      click_button 'Sign up'
      expect(page).to have_content("You're in!")
      expect(page).to have_content("Sign Out")

    end

    scenario 'required information is not supplied' do
      click_button 'Sign up'

      expect(page).to have_content("can't be blank")
      expect(page).to_not have_content("Sign Out")
    end

    scenario 'password confirmation does not match confirmation' do
      fill_in 'admin_password', with: 'password'
      fill_in 'Password Confirmation', with: 'somethingdifferent'

      click_button 'Sign Up'
      expect(page).to have_content("doesn't match")
      expect(page).to_not have_content("Sign Out")
    end
  end
end
