require 'rails_helper'

feature "admin edits a question" do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }
  let!(:question) { FactoryGirl.create(:question, survey: survey) }

  context "non-signed-in admin cannot edit a question" do
    before do
      visit survey_path(survey)
    end

    scenario "non-signed-in cannot see edit link" do
      expect(page).to_not have_content "edit question"
    end
  end

  context "signed in admin edits survey" do
    before do
      sign_in_as(admin)
      visit survey_path(survey)
      click_link "Edit Question"
    end

    scenario "signed in admin sucessfully edits question" do

      expect(page).to have_content "submit edit"

      fill_in 'body', with: "Ya but how do you really feel about it?"

      click_button "submit edit"

      expect(page).to have_content "Ya but how do you really feel about it?"
      expect(page).to have_content "Question edited successfully"
    end

    context "signed in admin tries to edit other admins survey" do
      let(:admin2) { FactoryGirl.create(:admin) }

      before do
        sign_out
        sign_in_as(admin2)
        visit survey_path(survey)
        click_link "edit question"
      end

      scenario "admin can edit other admins survey" do

        fill_in 'body', with: "Blardggg"
        click_button "edit question"

        expect(page).to have_content("Blardggg")
        expect(page).to have_content("question edited successfully")
      end
    end
    scenario "admin does not fill in correct information" do
      fill_in 'body', with: ""

      click_button "edit question"
      expect(page).to have_content "Body can't be blank"
    end
  end
end
