module BasicAuthentication
  def basic_authentication
    unless Rails.env.test?
      authenticate_or_request_with_http_basic do |username,password|
        @user = User.authenticate(username,password)
        session[:userid] = @user.id if @user
      end
    end
  end
end
