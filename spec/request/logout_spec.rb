require 'spec_helper'

describe "Sessions" do
  describe "logout" do
    before(:each) do
      create_user("test")
      login("test")
    end

    it "layout" do
      visit root_path
      user_nav.should_not have_link('Login')
      user_nav.should have_link('Logout')
    end

    context "link to logout" do
      before(:each) do
        visit root_path
        click_link 'Logout' 
      end
    
      #it "redirects to the root path" do
      #  page.current_path.should eq root_path 
      #end
    end

    context "logout user" do
      it "should show a logged-out flash message" do
        visit logout_path
        page.should have_notice("Logged out.")
      end

      it "should not display logout as a link option" do
        visit logout_path
        user_nav.should_not have_link('Logout')
      end
    end
  end
end
