require 'rails_helper'

feature "admin deletes a survey" do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }
  context "non-signed-in user" do
    before do
      visit root_path
    end

    scenario "non-signed-in cannot see delete links" do
      expect(page).to_not have_content "Delete Survey"
    end
  end

  context 'signed in admin' do
    before do
      sign_in_as(admin)
      visit survey_path(survey)
    end

    scenario "admin sees delete button for survey" do
      expect(page).to have_content "Delete Survey"
    end

    scenario "admin successfully deletes survey" do
      click_link "Delete Survey"
      expect(page).to_not have_content survey.title
    end
  end
end
