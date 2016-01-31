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

      expect(page).to have_content 'New Question'
      expect(page).to have_content 'Edit Question'
      expect(page).to have_content 'Delete Question'
    end
    scenario "admin can see options for creating a question" do
      visit new_survey_question_path(survey)

      expect(page).to have_content 'Add Question'
      expect(page).to have_content 'Rating'
      expect(page).to have_content 'Multiple choice'
      expect(page).to have_content 'Require'
    end

    scenario "admin can see options for creating a question surveys index" do
      visit survey_questions_path(survey)

      expect(page).to have_content 'New Question'
      expect(page).to have_content 'Edit Question'
      expect(page).to have_content 'Delete Question'
    end

    scenario "admin adds tries to add a blank question" do
      visit new_survey_question_path(survey)
      fill_in 'Body', with: ""
      click_button 'Add Question'

      expect(page).to_not have_content "Your question has been successfully added"
      expect(page).to have_content "Body can't be blank"
    end

    scenario "admin adds a new question successfully" do
      visit new_survey_question_path(survey)
      fill_in 'Body', with: "what do you think?"
      click_button 'Add Question'

      expect(page).to have_content "Your question has been successfully added"
      expect(page).to have_content "what do you think?"
    end
  end
end
