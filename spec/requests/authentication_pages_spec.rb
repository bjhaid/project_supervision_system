require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}

  describe "Sign in page" do
    before {visit signin_path}
    it { page.should have_selector('h1', text: 'Sign in') }
    it { page.should have_title('Sign in') }
  end

  context "signin" do
    before {visit signin_path}
    context "with invalid information" do
      before { click_button "Sign in" }
      it { page.should have_title('Sign in') }
      it { page.should have_selector('div.alert-error') }
      context "after visiting another page " do 
        before { click_link "Home"}
        it { page.should_not have_selector('div.alert.error') }
      end
    end
    context "with valid information"  do
      let(:user) { FactoryGirl.create(:user) } 
      before do
        visit signin_path
        fill_in "session_matric_no", with: user.matric_no
        fill_in "session_password", with: user.password
        click_button "Sign in"
      end

      it { page.should have_title(user.name) }
      it { page.should have_link('Profile', href: user_path(user)) }
      it { page.should have_link('Sign out', href: signout_path) }
      it { page.should_not have_link('Sign in', href: signin_path) }
    end
  end  
end
