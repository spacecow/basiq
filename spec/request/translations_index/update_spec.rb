# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Translations" do
  describe "index" do
    before(:each) do
      signin_admin
    end

    context "update translation" do
      it "english" do
        create_translation('aadog','dog','en')
        #I18n.backend.store_translations('en.categories', {'rock_science' => 'rock_science'}, :escape => false)
        visit translations_path
        fill_in 'en_0_value', :with => 'cat'
        click_button 'Update Translations'
        I18n.t("aadog",:locale=>:en).should eq 'cat'
        TRANSLATION_STORE.del('en.aadog')
      end 

      #it "persian" do
      #  I18n.backend.store_translations('ir.categories', {'rock_science' => 'rock_science'}, :escape => false)
      #  visit translations_path
      #  fill_in 'ir_0_value', :with => 'علم'
      #  click_button 'Update Translations'
      #  I18n.t("categories.rock_science",:locale=>:ir).should eq 'علم'
      #end 
    end
  end
end
