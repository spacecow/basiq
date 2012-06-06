#def login(user="test",password="secret")
def login(userid="test",password="secret")
  visit login_path
  fill_in "Login", :with => userid 
  fill_in "Password", :with => password 
  click_button "Login"
end

def login_admin 
  user = create_admin(:email=>'admin@example.com')
  login('admin@example.com')
  user
end
def login_member 
  user = create_member(:email=>'member@example.com')
  login('member@example.com')
  user
end

def create_user(user)
  FactoryGirl.create(:user,username:user)
end
