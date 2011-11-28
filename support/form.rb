def error_field(attr)
  find(:css, "li#user_#{attr}_input p.inline-errors")
end
