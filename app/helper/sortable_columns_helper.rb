module SortableColumnsHelper
  def sortable(col, title = col.titleize)
    css_class = col == sort_column ? sort_direction : nil
    direction = col == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, {:sort => col, :direction => direction}, {:class => css_class}
  end
end
