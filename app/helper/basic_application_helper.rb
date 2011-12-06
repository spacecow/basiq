module BasicApplicationHelper
  def minititle(s); raw "<h2>#{s}</h2>" end
  def new(s); t('labels.new',:o=>t(s)) end
  def pt(s); t(s).pluralize end
  def subtitle(s); raw "<h3>#{s}</h3>" end
  def sure?; t('messages.sure?') end
  def title(s)
    content_for(:title){ s.to_s }
    raw "<h1>#{s}</h1>"
  end
end
