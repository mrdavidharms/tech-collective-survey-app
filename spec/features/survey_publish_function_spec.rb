require 'rails_helper'

feature 'survey publish function' do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }

  context 'signed in admin' do
    before do
      sign_in_as(admin)
    end

    scenario 'signed in admin can see surveys on root path' do
      visit root_path

      expect(page).to have_content(survey.title)
    end

    scenario 'admin marks a survey to publish' do
      visit new_survey_path
      fill_in 'Title', with: "Published survey"
      fill_in 'Group', with: "Group for people"
      choose 'survey_publish_true'
      click_button 'Create Survey'

      expect(page).to have_content "Survey Added Successfully"
      expect(page).to have_content "Published survey"
      expect(page).to have_content "Group for people"

    end

    context 'non signed in user' do
      scenario 'user can see published survey on front page' do
        sign_out
        published_survey = FactoryGirl.create(:survey, title: "publisheddooss", admin: admin, publish: true )
        visit root_path
        expect(page).to have_content(published_survey.title)
        expect(page).to_not have_content(survey.title)
      end
    end
  end
end
