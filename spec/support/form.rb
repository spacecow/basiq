def selected_value(s)
  begin
    find_field(s).find(:xpath,"//option[@selected='selected']").text
  rescue
    nil 
  end
end
def options(lbl)
  find_field(lbl).all(:css,"option").map{|e| e.text.blank? ? "BLANK" : e.text}.join(', ')
end

