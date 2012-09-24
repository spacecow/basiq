require 'spec_helper'

describe "Translations" do
  describe "index" do
    before(:each) do
      signin_admin
      visit translations_path
    end

#    it "creating a category updates the category model" do
#      locale = create_locale('en.categories')
#      create_category('java')
#      Category.last.names_depth_cache_en.should eq "translation missing: en.categories.java"
#      fill_in 'Key', :with => 'java'
#      fill_in 'Value', :with => 'java'
#      fill_in 'Locale', :with => locale.id 
#      click_button 'Create Translation'
#      Category.last.names_depth_cache_en.should eq 'java'
#    end 

    context "create translation" do
      before(:each) do
        fill_in 'Key', :with => 'aadog'
        fill_in 'Value', :with => 'dog'
        fill_in 'Locale', with:'<<<en>>>'
      end

      context "create locale on the fly" do
        context "with existing locale" do
          before(:each) do
            locale = FactoryGirl.create(:locale, name:'en')
            fill_in 'Locale', with:locale.id
          end

          it "adds no locale to the database" do
            lambda{ click_button "Create"
            }.should change(Locale,:count).by(0)
          end 

          it "sets the value" do
            click_button 'Create Translation'
            TRANSLATION_STORE['en.aadog'].should eq '"dog"'
          end
        end

        context "with a new locale" do
          before(:each) do
            fill_in 'Locale', with:'<<<en>>>'
          end

          it "adds a locale to the database" do
            lambda{ click_button "Create"
            }.should change(Locale,:count).by(1)
          end 

          it "sets the value" do
            click_button 'Create Translation'
            TRANSLATION_STORE['en.aadog'].should eq '"dog"'
          end
        end

        context "with a new locale that already exists" do
          before(:each) do
            locale = FactoryGirl.create(:locale, name:'en')
            fill_in 'Locale', with:locale.id
          end

          it "adds no locale to the database" do
            lambda{ click_button "Create"
            }.should change(Locale,:count).by(0)
          end 

          it "sets the value" do
            click_button 'Create Translation'
            TRANSLATION_STORE['en.aadog'].should eq '"dog"'
          end
        end
      end

      it "adds no translation to the database"
     #  do
     #   lambda do
     #     click_button 'Create Translation'
     #   end.should change(Translation,:count).by(0)
     # end

      context "errors:" do
        it "key cannot be blank" do
          fill_in 'Key', :with => ''
          click_button 'Create Translation'
          div(:key).should have_blank_error
        end
        it "value cannot be blank" do
          fill_in 'Value', :with => ''
          click_button 'Create Translation'
          div(:value).should have_blank_error
        end
        it "locale cannot be blank" do
          fill_in 'Locale', :with => ''
          click_button 'Create Translation'
          div(:locale).should have_blank_error
        end
      end #errors

      after(:each) do
        TRANSLATION_STORE.del('en.aadog')
      end
    end #create translation
  end #index
end
