def options(lbl,scope=nil)
  if scope.nil?
    find_field(lbl).all(:css,"option").map{|e| e.text.blank? ? "BLANK" : e.text}.join(', ')
  else
    scope.find_field(lbl).all(:css,"option").map{|e| e.text.blank? ? "BLANK" : e.text}.join(', ')
  end
end
def selected_value(s)
  begin
    find_field(s).find(:xpath,"//option[@selected='selected']").text
  rescue
    nil 
  end
end
def textfield(i); li(i).find(:css,'input') end
def textfield_id(i); textfield(i)[:id] end
