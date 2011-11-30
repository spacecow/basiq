def signup
  fill_in "Email", :with => "test@example.com"
  fill_in "Password", :with => "secret"
  fill_in "Confirmation", :with => "secret"
  click_button "Create User"
end
