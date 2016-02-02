require 'rails_helper'

feature 'admin deletes a question' do
  context "non signed in can't see delete button" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:survey) { FactoryGirl.create(:survey, admin: admin) }
    let!(:question) { FactoryGirl.create(:question, survey: survey) }

    before do
      sign_in_as(admin)
      visit survey_questions_path(survey)
    end

    scenario "admin sees delete button for question" do
      expect(page).to have_button "Delete Question"
    end

    scenario "admin successfully deletes question" do
      click_button "Delete Question"
      expect(page).to_not have_content question.body
    end
  end
end
