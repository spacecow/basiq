module BasicApplicationController
  def alertify(s); t("alerts.#{s}") end
  def created(s,i=0,pl=nil)
    if i == 1 
      t('successes.created_nos',:o=>t(s),:i=>1,:v=>t(:was))
    elsif i > 1
      t('successes.created_nos',:o=>t(pl),:i=>i,:v=>(:were))
    else
      t("successes.created",:o=>t(s)) 
    end
  end
  def deleted(s); t("successes.deleted",:o=>t(s)) end
  def notify(s); t("notices.#{s}") end
  def not_created(s)
    t("alerts.not_created",:o=>t(s))
  end
  def pt(s); t(s).pluralize end
  def updated(s); t("successes.updated",:o=>t(s)) end

  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end

  def session_userid(s); session[:userid] = s end
end
