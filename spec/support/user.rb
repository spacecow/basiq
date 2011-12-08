def create_admin(h={});
  create_user h.merge({:roles_mask=>User.role(:admin)})
end
def create_user(h={}); Factory(:user,h) end
def signup(login="test@example.com")
  fill_in "Email", :with => login
  fill_in "Password", :with => "secret"
  fill_in "Confirmation", :with => "secret"
  click_button "Create User"
end
