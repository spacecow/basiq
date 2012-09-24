require 'spec_helper'

describe 'Sessions destroy' do
  context "logout" do
    before(:each) do
      login
      visit posts_path(month:'2012/7')
      user_nav.click_link 'Logout'
    end

    it "redirects to the root page" do
      current_path.should eq posts_path
    end

    it "redirects to the correct root page" do
      page.should have_content('July 2012')
    end

    it "shows a logged-out flash message" do
      page.should have_notice('Logged out')
    end

    it "shows the login link again" do
      user_nav.should have_link 'Login'
    end
    
    #current_path.should eq user_path(member)
  end
end
