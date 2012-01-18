# ERRORS -------------------------------------
def have_error(err,no=nil)
  err = I18n.t("activerecord.errors.messages.#{err.to_s}",:count=>no) if err.instance_of? Symbol
  have_css("p.inline-errors",:text=>err)
end
def have_blank_error; have_error(:blank) end
def have_confirmation_error
  have_error(:confirmation)
end
def have_duplication_error; have_error(:taken) end
def have_greater_than_error(no)
  have_error(:greater_than,no)
end
def have_numericality_error
  have_error(:numericality)
end
def have_hint(s)
  have_css("p.inline-hints",:text=>s)
end

# FLASH --------------------------------------
def have_flash(type,s="") 
  if s.empty?
    have_css("div#flash_#{type}")
  else
    have_css("div#flash_#{type}",:text=>s) 
  end
end
def have_alert(s=""); have_flash(:alert,s) end
def have_notice(s=""); have_flash(:notice,s) end
def have_deleted_notice_for(s)
  have_notice("Successfully deleted #{I18n.t(s)}.")
end


def have_image(s); have_xpath("//img[@alt='#{s}']") end
def have_a_table(id); have_css("table##{id}") end
def have_link(s); have_css("a",:text=>s) end

def have_title(s); have_css("h1",:text=>s) end
def have_subtitle(s); have_css("h3",:text=>s) end

def li(s,i=0)
  return lis[s] if s.instance_of? Fixnum
  if s.instance_of? Symbol
    #find(:css, "li##{tag_id(s,:li)}") if i<0
    all(:css, "li##{tag_id(s,:li)}")[i]
  elsif s.instance_of? String
    #find(:css,"li##{tag_id(lbl_id(s),:li)}") if i<0
    all(:css,"li##{tag_id(lbl_id(s),:li)}")[i]
  else
    #s.find(:css,'li') if i<0
    s.all(:css,'li')[i]
  end
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

# DIVS --------------------------------------

def have_div(id); have_css("div##{id}") end
def bottom_links; div('bottom_links') end
def div(id,i=-1)
  if i<0
    find(:css,"div##{id}")
  else
    all(:css,"div.#{id}")[i] 
  end
end
def divs(s); all(:css, "div.#{s}") end
def search_bar; div(:search_bar) end
def site_nav; div(:site_nav) end
def user_nav; div(:user_nav) end

private
  def lbl_id(s); find(:css,'label',:text=>s)[:for] end
