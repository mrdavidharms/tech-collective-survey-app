require 'rails_helper'
feature 'admin sees list of answers' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:user_survey, admin: admin) }
  let!(:other_survey) { FactoryGirl.create(:user_survey, admin: admin, title: "other survey") }
  let!(:question1) { FactoryGirl.create(:question, survey: survey, text: true, rating: true) }
  let!(:question2) { FactoryGirl.create(:question, survey: survey, rating: true) }
  let!(:question3) { FactoryGirl.create(:question, survey: survey, text: true) }
  let!(:question4) { FactoryGirl.create(:question, survey: other_survey, text: true) }
  let!(:answer1) { FactoryGirl.create(:answer, question: question1, answer: "it was cool", rating_answer: "10") }
  let!(:answer2) { FactoryGirl.create(:answer, question: question2, rating_answer: "5") }
  let!(:answer3) { FactoryGirl.create(:answer, question: question3, answer: "it was very nice") }
  let!(:answer4) { FactoryGirl.create(:answer, question: question4, answer: "it was very very something else") }
  context 'logged in admin' do
    before do
      sign_in_as(admin)
      visit surveys_path
    end
    scenario 'admin sees lists of surveys' do
      expect(page).to have_content survey.title
      expect(page).to have_content other_survey.title
    end
  end
  context 'admin clicks first survey sees correct questions and answers' do
    before do
      sign_in_as(admin)
      visit surveys_path
      click_button "see #{survey.title} answers"
    end
    scenario "admin should see survey title as header" do

      expect(page).to have_content survey.title
    end
    scenario "admin should see questions associated with survey" do

      expect(page).to have_content question1.title
      expect(page).to have_content question2.title
      expect(page).to have_content question3.title
    end
    scenario "admin should see answers associated with survey" do

      expect(page).to have_content answer1.answer
      expect(page).to have_content answer1.answer_rating
      expect(page).to have_content answer2.answer_rating
      expect(page).to have_content answer3.answer
    end
  end
end
