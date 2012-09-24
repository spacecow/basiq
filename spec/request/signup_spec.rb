require 'spec_helper'

describe "Users" do
  describe "root" do
    before(:each){ visit root_path }

    it "layout" do
      user_nav.should have_link('Signup')
    end

    it "link to signup" do
      user_nav.click_link 'Signup'
      current_path.should eq signup_path
    end
  end

  describe "new" do
    before(:each){ visit signup_path }

    context "layout" do
      it "has a title" do
        page.should have_title('Signup')
      end
  
      it "has a userid field" do
        value('Userid').should be_nil
      end

      it "has an email field" do
        value('Email').should be_nil
      end

      it "has a password field" do
        value('Password').should be_nil
      end

      it "has a password confirmation field" do
        value('Confirmation').should be_nil
      end

      it "has a create user button" do
        page.should have_submit_button('Create User')
      end
    end

    context "cant signup if already logged in" do
      before(:each) do
        create_member(:email=>'member@email.com')
        login('member@email.com')
        visit signup_path
      end

      it "redirects to the welcome page" do
        current_path.should eq welcome_path

      end
      it "shows an alert flash message" do
        page.should have_alert('You already have an account.')
      end
    end

    context "creates a new user" do
      it "redirects to the root page" do
        signup
        current_path.should eq root_path
      end

      it "increases the user count" do
        lambda do 
          signup
        end.should change(User,:count).by(1)
      end

      it "creates a salt" do
        signup
        User.last.password_salt.should_not be_nil
      end

      it "creates an encrypted password" do
        signup
        User.last.password_hash.should_not be_nil
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
        li(:password_input).should have_blank_error
      end

      it "email field cannot be empty" do
        fill_in "Email", :with => ""
        click_button "Create User"
        li(:email).should have_blank_error
      end

      it "email must be unique" do
        create_user("test@email.com")
        fill_in "Email", :with => "test@email.com"
        click_button "Create User"
        li(:email).should have_duplication_error
      end

      it "userid must be unique" do
        FactoryGirl.create(:user,:userid=>"test")
        fill_in "Userid", :with => "test"
        click_button "Create User"
        li(:userid).should have_duplication_error
      end

      it "userid can be blank" do
        FactoryGirl.create(:user,:userid=>"")
        fill_in "Userid", :with => ""
        click_button "Create User"
        li(:userid).should_not have_duplication_error
      end

      it "password confirmation is needed" do
        fill_in "Password", :with => "right"
        fill_in "Confirmation", :with => "wrong"
        click_button "Create User"
        li(:password_input).should have_confirmation_error
      end
    end
  end
end
