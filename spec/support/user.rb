def create_admin(h={}); create_user_with_role(:admin,h) end
def create_god(h={}); create_user_with_role(:god,h) end
def create_member(h={}); create_user_with_role(:member,h) end
def create_miniadmin(h={}); create_user_with_role(:miniadmin,h) end
def create_vip(h={}); create_user_with_role(:vip,h) end
def signup(login="test@example.com")
  visit signup_path
  fill_in "Userid", :with => login.split('@')[0]
  fill_in "Email", :with => login
  fill_in "Password", :with => "secret"
  fill_in "Confirmation", :with => "secret"
  click_button "Create User"
end

private

  def create_user_with_hash(h={}); Factory(:user,h) end
  def create_user_with_role(s,h={})
    create_user_with_hash h.merge({:roles_mask=>User.role(s)})
  end
