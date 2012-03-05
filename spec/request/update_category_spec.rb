require 'spec_helper'

describe "Categories" do
  before(:each){ login_admin }

  context "edit, update category" do
    before(:each) do
      word = create_word("cat","has a tail")
      visit edit_word_path(word)
    end
    
    it "does not change the owner count in the database" do
      lambda do
        click_button "Update #{Category.owner}"
      end.should change(Category.owner,:count).by(0)
    end

    context "no category" do
      before(:each){ fill_in 'Category', with:''}

      it "adds no category to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(0)
      end
      it "adds no categorization to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Categorization,:count).by(0)
      end
    end

    context "with existing category" do
      before(:each) do
        category = create_category('poem')
        fill_in 'Category', with:category.id 
      end

      it "adds no category to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(0)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Categorization,:count).by(1)
      end

      it "connects the category to the owner" do
        click_button "Update #{Category.owner}"
        Categorization.last_owner.should eq Category.last_owner
        Categorization.last.category.should eq Category.last
      end
    end

    context "with existing categories" do
      before(:each) do
        poem = create_category('poem')
        novel = create_category('novel')
        fill_in 'Category', with:"#{poem.id}, #{novel.id}" 
      end

      it "adds no categories to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(0)
      end
      it "adds categorizations to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Categorization,:count).by(2)
      end

      it "connects the categories to the owner" do
        click_button "Update #{Category.owner}"
        Categorization.first_owner.should eq Category.first_owner
        Categorization.first.category.should eq Category.all[-2]
        Categorization.last_owner.should eq Category.last_owner
        Categorization.last.category.should eq Category.last
      end
    end

    context "with new category" do
      before(:each) do
        fill_in 'Category', with:"NE" 
      end

      it "adds a category to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(1)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Categorization,:count).by(1)
      end

      it "connects the category to the owner" do
        click_button "Update #{Category.owner}"
        Categorization.last_owner.should eq Category.last_owner
        Categorization.last.category.should eq Category.last
      end
    end

    context "with new category that already exists" do
      before(:each) do
        create_category('poem')
        fill_in 'Category', with:'poem' 
      end

      it "adds no category to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(0)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Categorization,:count).by(1)
      end

      it "connects the category to the owner" do
        click_button "Update #{Category.owner}"
        Categorization.last_owner.should eq Category.last_owner
        Categorization.last.category.should eq Category.last
      end
    end

    context "with new category with digits" do
      before(:each) do
        fill_in 'Category', with:'666' 
      end

      it "adds a category to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(1)
      end
      it "adds a categorization to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Categorization,:count).by(1)
      end
    end

    context "treed category, with non existing categories" do
      before(:each) do
        if I18n.locale == :en
          fill_in 'Category', with:'poem/Limmerick'
        else
          fill_in 'Category', with:'poem\Limmerick'
        end
      end

      it "adds categories to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(2)
      end

      it "categories are chained" do
        click_button "Update #{Category.owner}"
        Category.last.parent.should eq Category.all[-2]
        Category.all[-2].children.should eq [Category.last]
      end
    end

    context "treed category, with a new category" do
      before(:each) do
        create_category('poem')
        if I18n.locale == :en
          fill_in 'Category', with:'poem/Limmerick'
        else
          fill_in 'Category', with:'poem\Limmerick'
        end
      end

      it "adds categories to the database" do
        lambda do
          click_button "Update #{Category.owner}"
        end.should change(Category,:count).by(1)
      end

      it "categories are chained" do
        click_button "Update #{Category.owner}"
        Category.last.parent.should eq Category.all[-2]
        Category.all[-2].children.should eq [Category.last]
      end

      it "a tree is saved in names_depth_cache" do
        click_button "Update #{Category.owner}"
        Category.all[-2].names_depth_cache_ir.should eq 'poem'
        Category.last.names_depth_cache_ir.should eq 'poem\Limmerick'
      end
    end
  end
end
