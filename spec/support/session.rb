def login(user="test",password="secret")
  visit login_path
  fill_in "Login", :with => user 
  fill_in "Password", :with => password 
  click_button "Login"
end
