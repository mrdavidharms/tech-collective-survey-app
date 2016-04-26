require "rails_helper"

feature "admins can add a new question for a survey" do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }
  let!(:question) { FactoryGirl.create(:question, survey: survey) }

  context "not logged in user" do
    scenario "cannot see question page" do
      visit survey_path(survey)

      expect(page).to_not have_content "Add Question"
    end
  end

  context "logged in admin" do
    before do

      sign_in_as(admin)
    end

    scenario "admin can see add question button with options next to it" do
      visit survey_questions_path(survey)

      expect(page).to have_button 'Add Question'
      expect(page).to have_button 'Edit Question'
      expect(page).to have_button 'Delete Question'
    end
    scenario "admin can see options for creating a question" do
      visit new_survey_question_path(survey)

      expect(page).to have_button 'Add Question'
      expect(page).to have_content 'Rating'
    end

    scenario "admin can see options for creating a question surveys index" do
      visit survey_questions_path(survey)

      expect(page).to have_button 'Add Question'
      expect(page).to have_button 'Edit Question'
      expect(page).to have_button 'Delete Question'
    end

    scenario "admin adds tries to add a blank question" do
      visit new_survey_question_path(survey)
      fill_in 'Body', with: ""
      click_button 'Add Question'

      expect(page).to_not have_content "Your question has been successfully added"
      expect(page).to have_content "Body can't be blank"
    end

    scenario "admin adds a new text question successfully" do
      visit new_survey_question_path(survey)
      fill_in 'Body', with: "what do you think?"
      check "question_text"
      click_button 'Add Question'

      expect(page).to have_content "Your question has been successfully added"
      expect(page).to have_button "Answers for: what do you think?"
    end
  end
end
