module BasicApplicationController
  def alertify(s); t("alerts.#{s}") end
  def created(s); t("successes.created",:o=>t(s)) end
  def deleted(s); t("successes.deleted",:o=>t(s)) end
  def notify(s); t("notices.#{s}") end
  def pt(s); t(s).pluralize end

  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end

  def session_userid(s); session[:userid] = s end
end
