require 'rails_helper'
feature 'admin sees list of answers' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:user_survey, admin: admin) }
  let!(:other_survey) { FactoryGirl.create(:user_survey, admin: admin, title: "other survey") }
  let!(:question1) { FactoryGirl.create(:question, survey: survey, text: true, rating: true) }
  let!(:answer1) { FactoryGirl.create(:answer, question: question1, answer: "it was cool", rating_answer: "10") }

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
      click_link survey.title
    end

    scenario "admin should see answers associated with survey1" do
      click_button "Answers for: #{question1.body}"

      expect(page).to have_content question1.body
      expect(page).to have_content answer1.answer
      expect(page).to have_content answer1.rating_answer
    end
  end
end
