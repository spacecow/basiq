require 'spec_helper'

describe "Categories" do
  context "admin links to" do
    before(:each) do
      p login_admin
      @ruby = create_category('ruby')
      visit category_path(@ruby)
    end

    context "edit category" do 
      before(:each) do
        save_and_open_page
        bottom_links.click_link 'Edit'
      end

      it "redirects to the categories index page" do
        page.current_path.should eq categories_path
      end

      it "category name is set"  do
        find_field('Name').value.should eq 'ruby'
      end
    end

    context "delete category" do 
      it "deletes a category from the database" do
        lambda do
          bottom_links.click_link 'Delete'
        end.should change(Category,:count).by(-1)
      end

      it "redirects to the category index page" do
        bottom_links.click_link 'Delete'
        page.current_path.should eq categories_path
      end
    end
  end
end
