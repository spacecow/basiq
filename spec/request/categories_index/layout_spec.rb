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
      @ruby = create_category('ruby')
      visit categories_path
    end

    it "has a nested_categories div" do
      page.should have_div(:nested_categories)
    end

    it "has a category class div" do
      div(:nested_categories).divs_no(:category).should be(1)
    end

    it "shows the name of the category as a link" do
      div(:category,0).div(:name).should have_link('ruby')
    end

    it "link to the category show page" do
      div(:category,0).div(:name).click_link 'ruby'
      current_path.should eq category_path(@ruby)
    end

    it "category has no edit link" do
      div(:category,0).div(:actions).should_not have_link('Edit')
    end
    it "category has no delete link" do
      div(:category,0).div(:actions).should_not have_link('Del')
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

    it "name field is empty" do
      find_field('Name').value.should be_nil
    end

    it "parent options are empty" do
      options('Parent').should eq "BLANK"
    end

    it "no parent is selected" do
      selected_value('Parent').should be_blank 
    end

    it "has a create category button" do
      page.should have_button('Create Category')
    end
  end

  context "index, admin layout with categories" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      programming = create_category('programming')
      create_category('ruby',programming.id)
      visit categories_path
    end

    it "category has an edit link" do
      div(:category,0).div(:actions).should have_link('Edit')
    end
    it "category has a delete link" do
      div(:category,0).div(:actions).should have_link('Del')
    end


    it "parent options has categories" do
      options('Parent').should eq "BLANK, programming, #{Category.separate(I18n.locale,'programming','ruby')}"
    end

    it "no parent is selected" do
      selected_value('Parent').should be_blank 
    end

    context "errors" do
      before(:each){ click_button 'Create Category' }

      it "parent options has categories" do
        options('Parent').should eq "BLANK, programming, #{Category.separate(I18n.locale,'programming','ruby')}"
      end

      it "no parent is selected" do
        selected_value('Parent').should be_blank 
      end
    end
  end

  context "index, admin update layout" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      create_category('programming')
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
      find_field('Name').value.should eq 'programming'
    end

    it "parent options does not include self" do
      options('Parent').should eq 'BLANK'
    end

    it "no parent is selected" do
      selected_value('Parent').should be_blank 
    end

    it "has an update category button" do
      page.should have_button('Update Category')
    end

    context "errors" do
      before(:each) do
        fill_in 'Name', with:''
        click_button 'Update Category'
      end

      it "parent options has categories" do
        options('Parent').should eq "BLANK"
      end

      it "no parent is selected" do
        selected_value('Parent').should be_blank 
      end
    end
  end
end
