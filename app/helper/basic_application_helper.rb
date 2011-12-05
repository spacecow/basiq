module BasicApplicationHelper
  def subtitle(subtitle); raw "<h3>#{subtitle}</h3>" end
  def sure?; t('messages.sure?') end
  def title(title)
    content_for(:title){ title.to_s }
    raw "<h1>#{title}</h1>"
  end
end
