class BasePresenter
  def initialize(object, parent=nil, template)
    @object = object
    @parent = parent
    @template = template
  end

  def h; @template end

  def new_link
    dcase = @object.to_s.downcase
    h.link_to h.new(dcase.to_sym), h.send("new_#{dcase}_path") if h.can? :new, @object
  end
  def edit_link
    dcase = @object.class.to_s.downcase
    h.link_to h.t(:edit), h.send("edit_#{dcase}_path", @object) if h.can? :edit, @object 
  end
  def delete_link
    dcase = @object.class.to_s.downcase
    h.link_to h.t(:delete), [@parent, @object], method: :delete, data:{confirm:h.sure?} if h.can? :destroy, @object 
  end

  class << self
    def presents(name)
      define_method(name) do
        @object
      end
    end
  end
end
