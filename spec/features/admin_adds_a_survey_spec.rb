require 'rails_helper'

feature "admin adds surveys", %{
  User Stories

  As a Tech Collective Administrator
  I want to be able to create separate surveys
  So I can add questions to them

  Acceptance Criteria:

  - I should be able to click a button to create a new survey
  - I should be asked what the name of the new survey is, and click accept
  - If I don’t put in a name I should get an error message
  - If I put in a name I should get a success message and be taken back to the list of surveys I’ve created
} do
    context "non signed in user" do
      scenario "cannot see page to create survey" do
        visit new_survey_path
        expect(page).to_not have_content "Sign in to create a survey"
      end
      scenario "cannot see create survey button" do
        visit root_path
        expect(page).to_not have_content "Add New Survey"
      end
    end
      context "Signed in admin" do
       let(:admin) { FactoryGirl.create(:admin) }
       let!(:survey) { FactoryGirl.create(:survey, admin: admin) }

       before do
         sign_in_as(admin)
       end

       scenario "Admin can see survey creation page" do
         click_link "Add New Survey"
         expect(page).to have_content "Title"
         expect(page).to have_content "Group"
       end
       scenario "Admin adds survey successfully" do

         visit new_survey_path
         fill_in 'Title', with: survey.title
         fill_in 'Group', with: survey.group
         click_button 'Add Survey'
         expect(page).to have_content "Survey Added Successfully"
         expect(page).to have_content survey.title
       end
    end
  end
