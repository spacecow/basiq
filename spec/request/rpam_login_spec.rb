require 'spec_helper'

describe "Sessions" do
  describe "new" do
    context "layout" do
      before(:each){ visit root_path }

      it "has a login link" do
        user_nav.should have_link('Login')
      end

      it "login link redirects to the login page" do
        user_nav.click_link 'Login'
        current_path.should eq login_path
      end

      it "has no logout link" do
        user_nav.should_not have_link('Logout')
      end
    end

    context "login user" do
      before(:each){ login } 

      it "should take you to the schema path" do
        page.current_path.should == schema_path
      end

      it "should show a logged-in flash message" do
        page.should have_notice("Logged in")
      end
    end

    it "login fails with incorrect information" do
      login("wrong")
      page.should have_alert("Invalid login or password.")
    end
  end
end
