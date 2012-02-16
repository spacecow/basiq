require 'spec_helper'

describe "Users" do
  describe "signup_confirmation" do
    context "confirmation with a wrong token" do
      before(:each) do
        visit signup_confirmation_path("wrong key")
      end

      it "shows an alert flash message" do
        page.should have_alert('Invalid signup token.')
      end

      it "redirects to the root page" do
        current_path.should eq root_path
      end
    end

    context "confirmation with a correct token, but with a not existing user" do
      before(:each) do
        token = SignupToken.create(email:'test@example.com')
        visit signup_confirmation_path(token.token)
      end

      it "shows an alert flash message" do
        page.should have_alert('User does not exist.')
      end

      it "redirects to the root page" do
        current_path.should eq root_path
      end
    end

    context "confirmation with a correct token" do
      before(:each) do
        @user = Factory(:user,email:'test@example.com')
        @token = SignupToken.create(email:@user.email)
      end

      it "logs the user in" do
        visit signup_confirmation_path(@token.token)
        page.should have_link('Logout')
        page.should_not have_link('Signup')
      end

      it "redirects to wanted page after signup" do
        visit user_path(@user)
        visit signup_confirmation_path(@token.token)
        current_path.should eq user_path(@user)
      end

      it "shows a notice flash message" do
        visit signup_confirmation_path(@token.token)
        page.should have_notice('Account activated. You are now logged in.')
      end

      it "redirects to the root page" do
        visit signup_confirmation_path(@token.token)
        current_path.should eq root_path
      end

      it "user and signup token are connected" do
        visit signup_confirmation_path(@token.token)
        User.last.signup_token.should eq SignupToken.last
      end
    end

    context "cant confirm signup if already logged in" do
      before(:each) do
        create_member(:email=>'member@email.com')
        login('member@email.com')
        user = Factory(:user,email:'test@example.com')
        token = SignupToken.create(email:user.email)
        visit signup_confirmation_path(token.token)
      end

      it "redirects to the welcome page" do
        current_path.should eq welcome_path

      end
      it "shows an alert flash message" do
        page.should have_alert('You already have an account.')
      end
    end
  end #signup confirmation
end
