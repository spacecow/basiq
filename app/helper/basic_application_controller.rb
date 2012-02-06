module BasicApplicationController
  def added_to_cart(o,name,i=1)
    if i==1
      t("added_to_cart.one", o:pl(o,i), name:name, count:i, :scope=>:successes)
    else
      t("added_to_cart.other", o:pl(o,i), name:name, count:i, :scope=>:successes)
    end
  end
  def alertify(s) t("alerts.#{s}") end
  def canceled(s) t('successes.canceled',:o=>t(s)) end
  def confirmed(s) t('successes.confirmed',:o=>t(s)) end
  def created(o,i=nil)
    i ? succ_no(:created,o,i) : succ(:created,o)
  end
  def created_adv(o,name); succ_adv(:created,o,name) end
  def created_state(mdl,state)
    t('successes.created_state',:o=>t(mdl),:state=>t(state).downcase)
  end
  def deleted(s) t('successes.deleted',:o=>t(s)) end
  def deleted_adv(o,name); succ_adv(:deleted,o,name) end
  def emptied(s) t('successes.emptied',:o=>t(s)) end
  def notify(s) t("notices.#{s}") end
  def not_created(o)
    t(:not_created, o:pl(o,1), :scope=>:alerts)
  end
  def pl(s,i=2)
    if i==1 
      t("#{s}.one",count:i) =~ /translation missing/ ? t(s) : t("#{s}.one",count:i)
    else
      t("#{s}.other",count:i)
    end
  end
  def pt(s) t(s).pluralize end
  def removed_from_cart(o,name,i=1)
    if i==1
      t("removed_from_cart.one", o:pl(o,i), name:name, count:i, :scope=>:successes)
    else
      t("removed_from_cart.other", o:pl(o,i), name:name, count:i, :scope=>:successes)
    end
  end
  def updated(o) succ(:updated,o) end
  def updated_adv(o,name); succ_adv(:updated,o,name) end

  def current_user
    @current_user ||= User.find(session[:userid]) if session[:userid]
  end

  def session_userid(s) session[:userid] = s end

  private

    def succ(lbl,o)
      t(lbl, o:pl(o,1), :scope=>:successes) 
    end
    def succ_adv(lbl,o,name)
      t(lbl, o:pl(o,1), name:name, :scope=>:successes_adv)
    end
    def succ_no(lbl,o,i)
      if i==1
        t("#{lbl}.one", o:pl(o,i), count:i, :scope=>:successes_no)
      else
        t("#{lbl}.other", o:pl(o,i), count:i, :scope=>:successes_no)
      end
    end
end
