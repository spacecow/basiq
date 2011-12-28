module PosModel
  def next_pos_child(pos)
    index = ordered_pos_child_index(pos)
    return nil if index.nil?
    return next_ordered_pos_child(index)
  end
  def prev_pos_child(pos)
    index = ordered_pos_child_index(pos)
    return nil if index.nil? || index == 0
    return prev_ordered_pos_child(index)
  end

  private

    def ordered_pos_child_index(pos); ordered_pos_child_pos.index(pos) end
    def ordered_pos_child_pos; children.select(:pos).order("pos asc").map(&:pos) end
    def next_ordered_pos_child(index); children.find_by_pos(next_ordered_pos_child_pos(index)) end
    def next_ordered_pos_child_pos(index); ordered_pos_child_pos[index+1] end 
    def prev_ordered_pos_child(index); children.find_by_pos(prev_ordered_pos_child_pos(index)) end
    def prev_ordered_pos_child_pos(index); ordered_pos_child_pos[index-1] end 
end
