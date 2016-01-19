feature "admin edits a survey" do
  let(:admin) { FactoryGirl.create(:admin) }
  let!(:survey) { FactoryGirl.create(:survey, admin: admin) }

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
      expect(page).to_not have_content(survey.title)
    end
  end

  context "signed in admin edits survey" do
    before do
      sign_in_as(admin)
      visit survey_path(survey)
      click_link "Edit"
    end

    scenario "signed in admin sucessfully edits survey" do

      expect(page).to have_content "Edit"

      fill_in 'Title', with: "Tech Force"
      fill_in 'Group', with: "Kids"
      click_button "Edit"

      expect(page).to have_content "Tech Force"
      expect(page).to have_content "Kids"
    end

    context "signed in user tries to edit someone elses piece" do
      let(:admin2) { FactoryGirl.create(:admin) }

      before do
        sign_in_as(admin2)
      end
      scenario "signed in admin tries to edit other admins survey" do
        context "admin can edit other admins survey" do
          visit survey_path(survey)
          fill_in 'Title', with: "Blardggg"
          fill_in 'Group', with: "Badadminss"
          click_button "Edit"
          expect(page).to have_content("Edit")
          expect(page).to have_content("Blardggg")
          expect(page).to_not have_content(survey.title)
        end
      end
    end
    scenario "admin does not fill in correct information" do
      fill_in 'Title', with: ""
      fill_in 'Group', with: ""

      click_button "Edit"
      expect(page).to have_content "Title can't be blank"
    end
  end
end
