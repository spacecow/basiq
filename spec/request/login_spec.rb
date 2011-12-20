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
        page.should have_notice("Logged in")
      end
    end

    it "login fails with incorrect information" do
      login("wrong")
      page.should have_alert("Invalid login or password.")
    end
  end
end
