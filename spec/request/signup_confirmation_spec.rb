require 'spec_helper'

describe "Users" do
  describe "signup_confirmation" do
    context "confirmation with a wrong token" do
      it "shows an alert flash message" do
        visit signup_confirmation_path("wrong key")
        page.should have_alert('Invalid signup token.')
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
    end

    context "confirmation with a correct token" do
      before(:each) do
        user = Factory(:user,email:'test@example.com')
        token = SignupToken.create(email:user.email)
        visit signup_confirmation_path(token.token)
      end

      it "shows a notice flash message" do
        page.should have_notice('Account activated. You are now logged in.')
      end

      it "user and signup token are connected" do
        User.last.signup_token.should eq SignupToken.last
      end
    end

    after(:each) do
      current_path.should eq root_path
    end
  end #signup confirmation
end
