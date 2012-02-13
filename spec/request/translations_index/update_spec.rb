# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Translations" do
  describe "index" do
    before(:each) do
      create_admin(:email=>'admin@example.com')
      login('admin@example.com')
      TRANSLATION_STORE.flushdb
    end

    context "update translation" do
      it "english" do
        I18n.backend.store_translations('en.categories', {'rock_science' => 'rock_science'}, :escape => false)
        visit translations_path
        fill_in 'en_0_value', :with => 'Rock Science'
        click_button 'Update Translations'
        I18n.t("categories.rock_science").should eq 'Rock Science'
      end 

      it "persian" do
        I18n.backend.store_translations('ir.categories', {'rock_science' => 'rock_science'}, :escape => false)
        visit translations_path
        fill_in 'ir_0_value', :with => 'علم'
        click_button 'Update Translations'
        I18n.t("categories.rock_science",:locale=>:ir).should eq 'علم'
      end 
    end
  end
end
