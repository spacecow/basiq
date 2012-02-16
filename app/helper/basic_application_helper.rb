module BasicApplicationHelper
  def add(o,i=1); labels(:add,o,i) end
  def add_to(s); jt('labels.add_to',:o=>jt(s)) end
  def cancel(o,i=1) labels(:cancel,o,i) end
  def confirm(o,i=1) labels(:confirm,o,i) end
  def create(o,i=1) labels(:create,o,i) end
  def edit(o,i=1) labels(:edit,o,i) end
  def empty(s); jt('labels.empty',:o=>jt(s)) end
  def formtitle(mdl)
    s = mdl.class.to_s.downcase
    subtitle(mdl.new_record? ? new(s) : edit(s))
  end
  def ft(s); jt("formtastic.labels.#{s.to_s}") end
  def mess(s,*opt) jt("messages.#{s}",*opt) end
  def minititle(s); raw "<h2>#{s}</h2>" end
  def new(o,i=1) labels(:new,o,i) end
  def remove(o,i=1) labels(:remove,o,i) end
  def submit(f,mdl)
    s = mdl.class.to_s.downcase
    f.submit mdl.new_record? ? create(s) : update(s) 
  end
  def subtitle(s); raw "<h3>#{s}</h3>" end
  def sure?; mess(:sure?) end
  def title(s)
    content_for(:title){ s.to_s }
    raw "<h1>#{s}</h1>"
  end
  def update(o,i=1) labels(:update,o,i) end

  private

    def labels(lbl,o,i)
      jt("labels.#{lbl}", o:pl(o,i))
    end
end
