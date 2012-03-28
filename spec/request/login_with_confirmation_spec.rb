require 'spec_helper'

describe "Sessions" do
  describe "login" do
    context "login user without confirmation" do
      before(:each) do
        user = create_user("test")
        user.signup_token = nil
        login("test")
      end

      it "redirects back to the login page" do
        page.current_path.should == login_path
      end

      it "gives an alert about account not being activated" do
        page.should have_alert("Account has not been activated.")
      end

      it "user is not logged in" do
        user_nav.should have_content("Login")
      end
    end

    context "login user without confirmation" do
      before(:each) do
        create_user("test")
        login("test")
      end

      it "should take you to the root path" do
        page.current_path.should == root_path
      end

      it "should show a logged-in flash message" do
        page.should have_notice("Logged in.")
      end

      it "should show the name of he logged in user" do
        page.should have_content("Logged in as test.")
      end
    end

    it "redirects to wanted page after login" do
      user = create_user("test")
      visit user_path(user)
      login("test")
      current_path.should eq user_path(user)
    end 
  end
end
