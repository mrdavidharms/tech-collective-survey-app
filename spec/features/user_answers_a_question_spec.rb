# require 'rails_helper'
#
# feature 'user answers a question' do
#   let(:admin) { FactoryGirl.create(:admin) }
#   let!(:user_survey) { FactoryGirl.create(:user_survey, admin: admin) }
#   let!(:question) { FactoryGirl.create(:question, survey: user_survey) }
#   context 'user is on index page' do
#     scenario 'User cannot see delete, edit, or add functions' do
#     visit root_path
#
#       expect(page).to_not have_content "Edit Survey"
#       expect(page).to_not have_content "Delete Survey"
#       expect(page).to_not have_content "Add Survey"
#     end
#
#     scenario 'User clicks a survey sees a question' do
#       visit root_path
#
#
#       click_link "#{user_survey.title}"
#             binding.pry
#       expect(page).to have_content(question.body)
#     end
#
#     scenario 'user cannot see edit, delete, or add functions for questions or admin name' do
#       visit survey_path
#       expect(page).to_not have_content "Edit Question"
#       expect(page).to_not have_content "Delete Question"
#       expect(page).to_not have_content "Add Question"
#       expect(page).to_not have_content(admin.name)
#     end
#
#     scenario 'user fills in question form with answer' do
#       visit survey_path
#       fill_in "answer_1", with: "Wubulubdubdub"
#     end
#   end
# end
