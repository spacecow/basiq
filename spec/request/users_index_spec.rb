require 'spec_helper'

describe "Users" do
  describe "index" do
    before(:each) do
      create_admin({:name=>"test"})
      login("test")
    end

    it "has a title" do
      visit users_path
      page.should have_title("Users")
    end

    it "lists all users" do
      visit users_path
      table("",0).should eq ["test"]
    end
  end
end
