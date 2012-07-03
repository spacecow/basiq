def create_user(user)
  FactoryGirl.create(:user,username:user)
end
