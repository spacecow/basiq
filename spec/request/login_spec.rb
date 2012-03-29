require 'spec_helper'

describe "Sessions" do
  it "login with userid"

  describe "login" do
    it "layout" do
      visit root_path
      user_nav.should have_link('Login')
      user_nav.should_not have_link('Logout')
    end

    it "link to login" do
      visit root_path
      click_link 'Login' 
      page.current_path.should eq login_path
    end
  end

  describe "new" do
    it "layout" do
      visit login_path
      page.should have_title('Login')
      div('signup').should have_content("Don't have an account?")
      div('signup').should have_button('Signup')
    end

    context "links to" do
      it "signup page" do
        visit login_path
        div('signup').click_button 'Signup'
        current_path.should eq signup_path
      end
    end

    it "login fails with incorrect information" do
      login("wrong")
      page.should have_alert("Invalid login or password.")
    end
  end
end
