require 'rails_helper'
feature "user answers a question" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey1) { FactoryGirl.create(:user_survey, admin: admin) }
  let!(:invisible_survey) { FactoryGirl.create(:survey, admin: admin) }
  let!(:other_survey) { FactoryGirl.create(:user_survey, admin: admin, group: "different group") }
  let!(:question1) { FactoryGirl.create(:question, survey: other_survey, text?: true) }
  let!(:question2) { FactoryGirl.create(:question, survey: other_survey, required?: true) }
  let!(:question3) { FactoryGirl.create(:question, survey: other_survey, multiple_choice: true) }
  let!(:question4) { FactoryGirl.create(:question, survey: other_survey, rating: true) }


  context "unsigned in user is on front page" do
    scenario "user sees groups of surveys" do
        visit root_path

        expect(page).to have_content survey1.title
        expect(page).to have_content other_survey.title
        expect(page).to_not have_content invisible_survey.title
    end
    scenario "user clicks on survey and is taken to questions" do
      visit root_path
      click_link other_survey.group

      expect(page).to have_content question1.body
      expect(page).to have_content question4.body
    end
  end
end
