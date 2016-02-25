require 'rails_helper'
feature 'Admin makes a question using rating function' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey1) { FactoryGirl.create(:user_survey, admin: admin) }
  let!(:question4) { FactoryGirl.create(:question, survey: survey1, rating: true) }

  context "logged in admin" do
    before do
      sign_in_as(admin)
      visit new_survey_question_path(survey1)
    end
    scenario "admin adds questions using rating function" do
      fill_in 'Body', with: "On a scale of 1-10 what do you think?"
      check "question_rating"
      click_button 'Add Question'

      expect(page).to have_content "Your question has been successfully added"
      expect(page).to have_content "On a scale of 1-10 what do you think?"
      expect(page).to have_content "1"
      expect(page).to have_content "10"
    end
    scenario "admin adds questions using rating and text function" do
      fill_in 'Body', with: "On a scale of 1-10 what do you think?"
      check "question_rating"
      check "question_text"
      click_button 'Add Question'
      click_link "On a scale of 1-10 what do you think?"

      find_field('answer_answer')

      expect(page).to have_content "On a scale of 1-10 what do you think?"
      expect(page).to have_content "2"

    end
  end
end
