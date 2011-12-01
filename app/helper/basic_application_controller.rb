module BasicApplicationController
  def alertify(s); t("alerts.#{s}") end
  def notify(s); t("notices.#{s}") end

  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end

  def session_userid(s); session[:userid] = s end
end
