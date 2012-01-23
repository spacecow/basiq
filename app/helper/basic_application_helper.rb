module BasicApplicationHelper
  def add(s); t('labels.add',:o=>t(s)) end
  def add_to(s); t('labels.add_to',:o=>t(s)) end
  def create(s); t('labels.create',:o=>t(s)) end
  def edit(s); t('labels.edit',:o=>t(s)) end
  def empty(s); t('labels.empty',:o=>t(s)) end
  def ft(s); t("formtastic.labels.#{s.to_s}") end
  def minititle(s); raw "<h2>#{s}</h2>" end
  def new(s); t('labels.new',:o=>t(s)) end
  def subtitle(s); raw "<h3>#{s}</h3>" end
  def sure?; t('messages.sure?') end
  def title(s)
    content_for(:title){ s.to_s }
    raw "<h1>#{s}</h1>"
  end
  def update(s); t('labels.update',:o=>t(s)) end
end
