def login
  visit login_path
  fill_in "Email", :with => "test@example.com"
  fill_in "Password", :with => "secret"
  click_button "Login"
end
