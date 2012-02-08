module BasicApplicationController
  def added_to_cart(o,name,i=1)
    if i==1
      jt("added_to_cart.one", o:pl(o,i), name:name, count:i, :scope=>:successes)
    else
      jt("added_to_cart.other", o:pl(o,i), name:name, count:i, :scope=>:successes)
    end
  end
  def alertify(s) jt("alerts.#{s}") end
  def canceled(s) jt('successes.canceled',:o=>jt(s)) end
  def confirmed(s) jt('successes.confirmed',:o=>jt(s)) end
  def created(o,i=nil)
    i ? succ_no(:created,o,i) : succ(:created,o)
  end
  def created_adv(o,name); succ_adv(:created,o,name) end
  def created_state(mdl,state)
    jt('successes.created_state',:o=>jt(mdl),:state=>jt(state).downcase)
  end
  def deleted(s) jt('successes.deleted',:o=>jt(s)) end
  def deleted_adv(o,name); succ_adv(:deleted,o,name) end
  def emptied(s) jt('successes.emptied',:o=>jt(s)) end
  def jt(s,*opt)
    TRANSLATION_LOG.debug s
    t(s,opt)
  end
  def notify(s) jt("notices.#{s}") end
  def not_created(o)
    jt(:not_created, o:pl(o,1), :scope=>:alerts)
  end
  def pl(s,i=2)
    if i==1 
      jt("#{s}.one",count:i) =~ /translation missing/ ? jt(s) : jt("#{s}.one",count:i)
    else
      jt("#{s}.other",count:i)
    end
  end
  def pt(s) jt(s).pluralize end
  def removed_from_cart(o,name,i=1)
    if i==1
      jt("removed_from_cart.one", o:pl(o,i), name:name, count:i, :scope=>:successes)
    else
      jt("removed_from_cart.other", o:pl(o,i), name:name, count:i, :scope=>:successes)
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
      jt(lbl, o:pl(o,1), :scope=>:successes) 
    end
    def succ_adv(lbl,o,name)
      jt(lbl, o:pl(o,1), name:name, :scope=>:successes_adv)
    end
    def succ_no(lbl,o,i)
      if i==1
        jt("#{lbl}.one", o:pl(o,i), count:i, :scope=>:successes_no)
      else
        jt("#{lbl}.other", o:pl(o,i), count:i, :scope=>:successes_no)
      end
    end
end
