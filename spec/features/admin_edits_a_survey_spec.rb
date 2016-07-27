require 'rails_helper'

feature "admin edits a survey" do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }
  let!(:question) { FactoryGirl.create(:question, survey: survey) }

  context "non-signed-in admin cannot edit a survey" do
    before do
      visit survey_path(survey)
    end

    scenario "non-signed-in cannot see edit link" do
      expect(page).to_not have_content "Edit"
    end

    scenario "non-signed-in is presented with error when visiting edit path" do
      visit edit_survey_path(survey)
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end

  context "signed in admin edits survey" do
    before do
      sign_in_as(admin)
      visit survey_questions_path(survey)
    end

    scenario "signed in admin sucessfully edits survey" do

      expect(page).to have_content "Edit"
      click_link "Edit"

      fill_in 'Title', with: "Tech Force"
      fill_in 'Group', with: "Kids"
      click_button "Update Survey"

      expect(page).to have_content "Tech Force"
      expect(page).to have_content "Kids"
      expect(page).to have_content "Survey edited successfully"
    end

    scenario 'admin edits a survey to publish' do
      click_link "Edit"

      fill_in 'Title', with: "Published Tech Force"
      fill_in 'Group', with: "Published Kids"
      choose 'survey_publish_true'

      click_button 'Update Survey'

      expect(page).to have_content "Survey edited successfully"
      expect(page).to have_content "Published Tech Force"
    end

    context "signed in admin tries to edit other admins survey" do
      let(:admin2) { FactoryGirl.create(:admin) }

      before do
        sign_out
        sign_in_as(admin2)
        visit survey_questions_path(survey)
      end

      scenario "admin can edit other admins survey" do

        click_link "Edit"

        fill_in 'Title', with: "Blardggg"
        fill_in 'Group', with: "Badadminss"
        click_button "Update Survey"

        expect(page).to have_content("Blardggg")
        expect(page).to have_content("Survey edited successfully")
      end
    end
    scenario "admin does not fill in correct information" do
      click_link "Edit"

      fill_in 'Title', with: ""
      fill_in 'Group', with: ""

      click_button "Update Survey"
      expect(page).to have_content "Title can't be blank"
    end
  end
end
