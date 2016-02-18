require 'rails_helper'
feature 'user only sees questions for survey they clicked on' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:user_survey, title: "survey 1", admin: admin) }
  let!(:other_survey) { FactoryGirl.create(:user_survey, title: "survey 2", admin: admin, group: "different group") }
  let!(:question1) { FactoryGirl.create(:question, survey: survey, text: true) }
  let!(:question3) { FactoryGirl.create(:question, survey: survey, text: true) }
  let!(:question5) { FactoryGirl.create(:question, survey: survey, text: true) }
  let!(:question2) { FactoryGirl.create(:question, survey: other_survey, text: true) }
  let!(:question4) { FactoryGirl.create(:question, survey: other_survey, text: true) }
  let!(:question6) { FactoryGirl.create(:question, survey: other_survey, text: true) }

  context "user takes survey" do
    before do
      visit root_path
    end
    scenario "user answers first question" do
      click_link survey.title
      fill_in "answer_answer", with: "It was ok"
      click_button 'Submit Answer'

      expect(page).to have_content 'answer saved'
      expect(page).to_not have_content question2.body
      expect(page).to have_content question3.body
    end
    scenario "user answers question on other survey" do
      click_link other_survey.title
      fill_in "answer_answer", with: "I liked it"
      click_button 'Submit Answer'

      expect(page).to have_content 'answer saved'
      expect(page).to have_content question4.body
      expect(page).to_not have_content question3.body
    end
    scenario "user finishes survey" do
      click_link other_survey.title
      fill_in "answer_answer", with: "I liked it"
      click_button 'Submit Answer'

      expect(page).to have_content 'answer saved'
      expect(page).to have_content question4.body
      expect(page).to_not have_content question3.body

      fill_in "answer_answer", with: "It was good"
      click_button 'Submit Answer'

      expect(page).to have_content 'Thank you for taking our survey!'
    end
  end
end
