def have_alert(s); have_flash(s,:alert) end
def have_error(s); have_css("p.inline-errors",:text=>s) end
def have_flash(s,type); have_css("div#flash_#{type}",:text=>s) end
def have_notice(s); have_flash(s,:notice) end
def li(s); find(:css, "li##{tag_id(s,:li)}") end
def table(row=nil, col=nil)
  table = all(:css, "table tr").map{|e| e.all(:css, "td").map(&:text)}.reject{|e| e.empty?}
  return table if row.nil?
  return table[row] if col.nil?
  return table[row][col]
end
def tag_id(s,tag); tag_ids(tag).select{|e| e=~/#{s}/}.first end
def tag_ids(tag); all(:css, tag.to_s).map{|e| e[:id]} end
