require 'rails_helper'
feature "user answers a question" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey1) { FactoryGirl.create(:user_survey, title: "something else", admin: admin) }
  let!(:invisible_survey) { FactoryGirl.create(:survey, admin: admin) }
  let!(:other_survey) { FactoryGirl.create(:user_survey, admin: admin, group: "different group") }
  let!(:question2) { FactoryGirl.create(:question, survey: other_survey, text: true, required: true) }
    # let!(:question5) { FactoryGirl.create(:question, survey: other_survey, rating: true, text: true, required: true) }

  context 'user answers a survey' do
    before do
      visit root_path
      click_link other_survey.title
    end
    scenario "user clicks on survey and is taken to questions" do

      expect(page).to have_content question2.body
    end
    scenario "user answers a questions a required question" do
      fill_in "answer_answer", with: ""
      click_button 'Submit Survey'

      # expect(page).to have_content 'Answer required'
    end
  end
end
