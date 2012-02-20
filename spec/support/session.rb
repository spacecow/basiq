def login(user="test",password="secret")
  visit login_path
  fill_in "Login", :with => user 
  fill_in "Password", :with => password 
  click_button "Login"
end

def login_admin 
  create_admin(:email=>'admin@example.com')
  login('admin@example.com')
end
