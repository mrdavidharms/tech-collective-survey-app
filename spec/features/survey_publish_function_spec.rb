require 'rails_helper'

feature 'survey publish function' do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }
  context 'signed in admin' do
    scenario 'signed in admin can see surveys on root path' do
      before do
        sign_in_as(admin)
      end
      visit root_path

      expect(page).to have_content(survey.title)
    end
  end
end
