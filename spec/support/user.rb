def create_admin(h={});
  create_user_with_hash h.merge({:roles_mask=>User.role(:admin)})
end
def create_miniadmin(h={});
  create_user_with_hash h.merge({:roles_mask=>User.role(:miniadmin)})
end
def create_user_with_hash(h={}); Factory(:user,h) end
def signup(login="test@example.com")
  fill_in "Login", :with => login
  fill_in "Password", :with => "secret"
  fill_in "Confirmation", :with => "secret"
  click_button "Create User"
end
