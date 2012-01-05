# ERRORS -------------------------------------
def have_error(s); have_css("p.inline-errors",:text=>s) end
def have_blank_error
  have_error("can't be blank")
end
def have_confirmation_error
  have_error("doesn't match confirmation")
end
def have_duplication_error;
  have_error "has already been taken"
end

# FLASH --------------------------------------
def have_flash(s,type); have_css("div#flash_#{type}",:text=>s) end
def have_alert(s); have_flash(s,:alert) end
def have_notice(s); have_flash(s,:notice) end
def have_deleted_notice_for(s)
  have_notice("Successfully deleted #{I18n.t(s)}.")
end
def have_a_table(id); have_css("table##{id}") end
def have_link(s); have_css("a",:text=>s) end
def have_title(s); have_css("h1",:text=>s) end
def li(s)
  return lis[s] if s.instance_of? Fixnum
  return find(:css, "li##{tag_id(s,:li)}") if s.instance_of? Symbol
  find(:css,"li##{tag_id(lbl_id(s),:li)}")
end
def lis; all(:css,"li") end
def row(i); table.all(:css,'tr')[i] end

# TABLESMAP ----------------------------------

def tablemaps
  ret = []
  tables.each_index{|i| ret.push tablemap(i)} 
  ret
end

def tablemap(id=0)
  tbl = table(id).all(:css,'tr').map{|e| e.all(:css,'td').map{|f| f.text.strip}}
  begin
    table(id).find(:css,'th')
    tbl.shift
    tbl.unshift table(id).first(:css,'tr').all(:css,'th').map{|e| e.text.strip}
  rescue
  end
  tbl
end
def tablerow(row,id=0); tablemap(id)[row] end
def tablecell(row,col,id=0); tablerow(row,id)[col] end

#def table(id=""); id.blank? ? find(:css,'table') : find(:css,"table##{id.to_s}") end
def table(id=0); tables[id] end
def tables; all(:css,'table') end
def tag_id(s,tag); tag_ids(tag).select{|e| e=~/#{s}/}.first end
def tag_ids(tag); all(:css, tag.to_s).map{|e| e[:id]} end

def div(s,i)
  all(:css,"div.#{s}")[i] 
end

private
  def lbl_id(s); find(:css,'label',:text=>s)[:for] end
