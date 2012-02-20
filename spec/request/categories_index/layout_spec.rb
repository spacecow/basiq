require 'spec_helper'

describe "Categories" do
  context "index, member layout without categories" do
    before(:each){ visit categories_path }   

    it "has a title" do
      page.should have_title('Categories')
    end

    it "has no categories div" do
      page.should_not have_div(:categories)
    end

    it "has a subtitle" do
      page.should_not have_subtitle('New Category')
    end
  end

  context "index, member layout with categories" do
    before(:each) do
      Factory(:category, name:'ruby')
      visit categories_path
    end

    it "has a categories div" do
      page.should have_div(:categories)
    end

    it "has a category class div" do
      div(:categories).divs_no(:category).should be(1)
    end

    it "shows the name of the category" do
      div(:category,0).div(:name).should have_content('ruby')
    end

    it "category has not edit link" do
      div(:category,0).div(:actions).should_not have_link('Edit')
    end
  end

  context "index, admin layout without categories" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      visit categories_path
    end

    it "has a subtitle" do
      page.should have_subtitle('New Category')
    end

    it "name field is emtpy" do
      value('Name').should be_nil
    end

    it "parent options are empty" do
      options('Parent').should eq "BLANK"
    end

    it "no parent is selected" do
      selected_value('Parent').should be_empty 
    end

    it "has a create category button" do
      page.should have_button('Create Category')
    end
  end

  context "index, admin layout with categories" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      Factory(:category,name:'programming')
      visit categories_path
    end

    it "category has an edit link" do
      div(:category,0).div(:actions).should have_link('Edit')
    end

    it "parent options has categories" do
      options('Parent').should eq "BLANK, programming"
    end

    it "no parent is selected" do
      selected_value('Parent').should be_empty 
    end
  end

  context "index, admin update layout" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      Factory(:category,name:'programming')
      visit categories_path
      div(:category,0).click_link('Edit')
    end

    it "redirects to the index page" do
      current_path.should eq categories_path
    end
  
    it "has a subtitle" do
      page.should have_subtitle('Edit Category')
    end

    it "fills in the name field" do
      value('Name').should eq 'programming'
    end

    it "has an update category button" do
      page.should have_button('Update Category')
    end
  end
end
