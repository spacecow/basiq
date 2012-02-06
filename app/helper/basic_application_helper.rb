module BasicApplicationHelper
  def add(s); t('labels.add',:o=>t(s)) end
  def add_to(s); t('labels.add_to',:o=>t(s)) end
  def cancel(o,i=1) labels(:cancel,o,i) end
  def confirm(o,i=1) labels(:confirm,o,i) end
  def create(o,i=1) labels(:create,o,i) end
  def edit(o,i=1) labels(:edit,o,i) end
  def empty(s); t('labels.empty',:o=>t(s)) end
  def ft(s); t("formtastic.labels.#{s.to_s}") end
  def mess(s) t(s,:scope=>:messages) end
  def minititle(s); raw "<h2>#{s}</h2>" end
  def new(o,i=1) labels(:new,o,i) end
  def subtitle(s); raw "<h3>#{s}</h3>" end
  def sure?; mess(:sure?) end
  def title(s)
    content_for(:title){ s.to_s }
    raw "<h1>#{s}</h1>"
  end
  def update(o,i=1) labels(:update,o,i) end

  private

    def labels(lbl,o,i)
      t(lbl, o:t(o,count:i), :scope=>:labels)
    end
end
