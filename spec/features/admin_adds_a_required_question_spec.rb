require 'rails_helper'
feature 'Admin makes a question using required function' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey1) { FactoryGirl.create(:user_survey, admin: admin) }
  let!(:question4) { FactoryGirl.create(:question, survey: survey1, rating: true) }

  context "logged in admin" do
    before do
      sign_in_as(admin)
      visit new_survey_question_path(survey1)
    end
    scenario "admin adds questions using rating function" do
      fill_in 'Body', with: "This question is required"
      check "question_require"
      click_button 'Add Question'

      expect(page).to have_content "Your question has been successfully added"
      expect(page).to have_content "This question is required"

    end
  end
end
