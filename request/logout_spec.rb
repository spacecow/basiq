require 'spec_helper'

describe "Sessions" do
  describe "destroy" do
    context "logout user" do
      it "should show a logged-out flash message" do
        visit logout_path
        page.should have_notice("Logged out.")
      end
    end
  end
end
