require 'spec_helper'

describe "Sessions" do
  describe "new" do
    context "login user" do
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
      test = create_user("test")
      visit user_path(test)
      login("test")
      current_path.should eq user_path(test)
    end 
  end
end
