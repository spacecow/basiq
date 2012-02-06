require 'spec_helper'

describe "Users" do

  describe "root" do
    it "layout" do
      visit root_path
      page.should have_link('Signup')
    end
    it "link to signup" do
      visit root_path
      click_link 'Signup'
      page.current_path.should eq signup_path
    end
  end

  describe "new" do
    before(:each) do
      visit signup_path
    end

    it "layout" do
      page.should have_title('Signup')
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
        page.should have_notice("Signed up and logged in.")
      end

      it "logs the user in" do
        signup
        page.should have_link('Logout')
        page.should_not have_link('Signup')
      end

      it "creates the user as a member" do
        signup
        User.last.roles_mask.should be User.role(:member)
      end
    end

    context "errors" do
      it "password field cannot be empty" do
        fill_in "Password", :with => ""
        click_button "Create User"
        li(:password).should have_blank_error
      end

      it "login field cannot be empty" do
        fill_in "Login", :with => ""
        click_button "Create User"
        li('Login').should have_blank_error
      end

      it "confirmation is needed" do
        fill_in "Password", :with => "right"
        fill_in "Confirmation", :with => "wrong"
        click_button "Create User"
        li(:password).should have_confirmation_error
      end

      it "login have to be unique" do
        create_user("taken") 
        fill_in "Login", :with => "taken"
        click_button "Create User"
        li('Login').should have_duplication_error
      end
    end
  end
end
