def have_alert(s); have_flash(s,:alert) end
def have_error(s); have_css("p.inline-errors",:text=>s) end
def have_flash(s,type); have_css("div#flash_#{type}",:text=>s) end
def have_notice(s); have_flash(s,:notice) end
def id(s,tag); ids(tag).select{|e| e=~/#{s}/}.first end
def ids(tag); all(:css, tag.to_s).map{|e| e[:id]} end
def li(s); find(:css, "li##{id(s,:li)}") end
