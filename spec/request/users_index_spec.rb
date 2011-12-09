require 'spec_helper'

describe "Users" do
  describe "index" do
    context "miniadmin view" do
      before(:each) do
        @user = create_miniadmin({:name=>"test"})
        login("test")
        visit users_path
      end

      it "has a title" do
        page.should have_title("Users")
      end

      it "lists users" do
        tablemap("",0).should eq %w(test) 
      end

      it "link to a user" do
        row(0).click_link("test")
        page.current_path.should eq user_path(@user)
      end

      it "cannot delete users" do
        row(0).should_not have_link("Del")
      end
    end

    context "admin view" do
      before(:each) do
        @user = create_admin({:name=>"test"})
        @other_user = create_user
        login("test")
        visit users_path
      end

      it "lists users" do
        tablemap("",0).should eq %w(test Del) 
      end

      context "delete a user" do
        it "remove that user" do
          lambda do
            row(1).click_link("Del")
          end.should change(User,:count).by(-1)
        end

        it "shows a flash message" do
          row(1).click_link("Del")
          page.should have_deleted_notice_for(:user)
        end

        it "returns one back to the index page" do
          row(1).click_link("Del")
          page.current_path.should eq users_path
        end

        it "admin cannot destroy himself"
      end
    end
  end
end
