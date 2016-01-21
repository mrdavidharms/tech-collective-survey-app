
module AuthenticationHelper
  def sign_in_as(admin)
    visit root_path
    click_link "Sign In"
    fill_in 'Name', with: admin.name
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'
  end

  def sign_out
    click_link "Sign Out"
  end

  def authorize_admin
    if !admin_signed_in?
      flash[:notice] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end
end
