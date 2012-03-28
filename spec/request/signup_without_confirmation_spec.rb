require 'spec_helper'

describe "Users" do
  describe "new" do
    context "creates a new user" do
      it "shows a flash message" do
        signup
        page.should have_notice("Signed up and logged in.")
      end

      it "logs the user in" do
        signup
        page.should have_link('Logout')
        page.should_not have_link('Signup')
      end

      it "redirects to wanted page after signup" do
        user = create_user("test")
        visit user_path(user)
        signup
        current_path.should eq user_path(user)
      end
    end
  end
end
