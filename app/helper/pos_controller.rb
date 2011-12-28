module PosController
  def ascend
    change_pos(parent,child,parent.next_pos_child(child.pos))
  end

  def descend
    change_pos(parent,child,parent.prev_pos_child(child.pos))
  end

  def change_pos(parent,child,change_to_child)
    redirect_to :back and return if change_to_child.nil?
    send(pos_function,child,change_to_child)
    switch_pos(child,change_to_child)
    redirect_to send("#{snake parent}_path", parent)
  end 

  private
    
    def snake(cl); cl.class.to_s.underscore end 
    def snakes(cl); snake(cl).pluralize end 
    def switch_pos(p1,p2)
      temp, p1.pos = p1.pos, 666; p1.save
      p2.pos, temp = temp, p2.pos; p2.save
      p1.pos = temp; p1.save
    end
end
