def have_a_table(id); have_css("table##{id}") end
def have_alert(s); have_flash(s,:alert) end
def have_blank_error; have_error("can't be blank") end
def have_error(s); have_css("p.inline-errors",:text=>s) end
def have_flash(s,type); have_css("div#flash_#{type}",:text=>s) end
def have_notice(s); have_flash(s,:notice) end
def have_title(s); have_css("h1",:text=>s) end
def li(s); find(:css, "li##{tag_id(s,:li)}") end
def table(id="", row=nil, col=nil)
  table = tables(id).map{|e| e.all(:css,"tr").map{|f| f.all(:css,"td").map(&:text)}}.first.reject{|e| e.empty?}
  return table if row.nil?
  return table[row] if col.nil?
  return table[row][col]
end
def tables(id=""); id.blank? ? all(:css,"table") : all(:css,"table##{id.to_s}") end
def tag_id(s,tag); tag_ids(tag).select{|e| e=~/#{s}/}.first end
def tag_ids(tag); all(:css, tag.to_s).map{|e| e[:id]} end
