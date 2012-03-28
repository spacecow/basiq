require 'spec_helper'

describe "Translations" do
  describe "index" do
    before(:each) do
      login_admin
      visit translations_path
    end

    context "layout" do
      it "has a title" do
        page.should have_title('Translations')
      end
      it "has a subtitle" do
        page.should have_subtitle('New Translation')
      end
      it "has an empty key field" do
        value('Key').should be_nil
      end
      it "has an empty value field" do
        value('Value').should be_nil
      end
      it "has no value hint" do
        li(:value).should_not have_hint
      end
      it "has an empty locale field" do
        value('Locale').should be_nil
      end
      it "has a Create Translation button" do
        page.should have_button('Create Translation')
      end

      context "translation list" do
        context "non-empty" do
          before(:each) do
            create_translation('aadog')
            visit translations_path
          end

          it "has a table for the list" do
            page.should have_a_table('translations') 
          end

          it "there exists an update button" do
            page.should have_button('Update Translations')
          end
    
          after(:each) do
            TRANSLATION_STORE.del('en.aadog')
          end
        end

        context "english, persian, pirate" do
          before(:each) do
            create_translation('aadog','dog','en')
            create_translation('pi','Pirate','pi')
            create_translation('pi','Pirate','en')
            visit translations_path
          end

          it "has two headers" do
            tableheader.should eq ['Key','English','Persian', 'Pirate']
          end
          it "shows one row" do
            value(:en_0_value).should eq 'dog'
          end

          after(:each) do
            TRANSLATION_STORE.del('en.aadog')
            TRANSLATION_STORE.del('pi.pi')
            TRANSLATION_STORE.del('en.pi')
          end
        end

        context "english, persian and persian" do
          before(:each) do
            create_translation('aadog','dog','en')
            create_translation('aabbq','BBQ','ir')
            create_translation('ja','Japanese','en')
            visit translations_path
          end

          it "has three headers" do
            tableheader.should eq ['Key','English','Persian']
          end
          it "shows two rows" do
            value(:en_0_value).should be_nil 
            value(:ir_0_value).should eq 'BBQ'
            value(:en_1_value).should eq 'dog'
            value(:ir_1_value).should be_nil 
          end

          after(:each) do
            TRANSLATION_STORE.del('en.aadog')
            TRANSLATION_STORE.del('ir.aabbq')
            TRANSLATION_STORE.del('en.ja')
          end
        end
      end
    end #layout

    #context "links to" do
    #  context "edit translation" do
    #    before(:each) do
    #      create_translation('dog','Dog','en')
    #      create_translation('bbq','BBQ','ir')
    #      visit translations_path
    #    end

    #    it "fill in a done translation" do
    #      cell(2,1).click_link 'Dog'
    #      value('Key').should eq 'dog' 
    #      value('Value').should eq 'Dog' 
    #      value('Locale').should eq 'en' 
    #    end
    #    it "no hint if value is filled in" do
    #      cell(2,1).click_link 'Dog'
    #      li(:value).should_not have_hint
    #    end
    #    context "fill in not yet done" do
    #      it "persian translation" do
    #        cell(2,2).click_link '-'
    #        value('Key').should eq 'dog' 
    #        value('Value').should be_nil 
    #        value('Locale').should eq 'ir' 
    #      end
    #      it "english translation" do
    #        cell(1,1).click_link '-'
    #        value('Key').should eq 'bbq' 
    #        value('Value').should be_nil 
    #        value('Locale').should eq 'en' 
    #      end
    #    end

    #    context "hint with the english translation for" do
    #      it "persian translation" do
    #        cell(2,2).click_link '-'
    #        li(:value).should have_hint('English: Dog')
    #      end
    #      it "english translation" do
    #        cell(1,1).click_link '-'
    #        li(:value).should_not have_hint
    #      end
    #    end
    #  end
    #end
  end
end
