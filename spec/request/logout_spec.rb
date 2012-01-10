require 'spec_helper'

describe "Sessions" do
  describe "root" do
    before(:each) do
      create_user("test")
      login("test")
    end

    it "layout" do
      visit root_path
      page.should_not have_link('Login')
      page.should have_link('Logout')
    end

    it "link to login" do
      visit root_path
      click_link 'Logout' 
      page.current_path.should eq root_path 
    end
  end

  describe "destroy" do
    context "logout user" do
      it "should show a logged-out flash message" do
        visit logout_path
        page.should have_notice("Logged out.")
      end
    end
  end
end
