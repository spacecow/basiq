require 'spec_helper'

describe "Users" do
  describe "new" do
    before(:each) do
      visit signup_path
    end

    context "creates a new user" do
      it "increases the user count" do
        lambda do 
          signup
        end.should change(User, :count).by(1)
      end

      it "creates a salt" do
        signup
        User.last.password_salt.should_not be_nil
      end

      it "creates an encrypted password" do
        signup
        User.last.password_hash.should_not be_nil
      end

      it "shows a flash message" do
        signup
        page.should have_notice("Signed up.")
      end

      it "creates the user as a member" do
        signup
        User.last.roles_mask.should be User.role("member")
      end
    end

    context "errors" do
      it "password field cannot be empty" do
        fill_in "Password", :with => ""
        click_button "Create User"
        error_field(:password).should have_content("can't be blank")
      end

      it "email field cannot be empty" do
        fill_in "Email", :with => ""
        click_button "Create User"
        error_field(:email).should have_content("can't be blank")
      end

      it "confirmation is needed" do
        fill_in "Password", :with => "right"
        fill_in "Confirmation", :with => "wrong"
        click_button "Create User"
        error_field(:password).should have_content("doesn't match confirmation")
      end

      it "email have to be unique" do
        Factory(:user, :email => "taken@example.com")
        fill_in "Email", :with => "taken@example.com"
        click_button "Create User"
        error_field(:email).should have_content("has already been taken")
      end
    end
  end
end
