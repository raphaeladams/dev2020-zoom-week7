# Treasure Hunt
# Raphael Adams

class TreasureMap
  @all_coords = Hash.new(".")

  def add_to_map(given_coords, item)
    if ["F", "W", "X"].include?(item.upcase)
      @all_coords[given_coords] = item.to_sym
    else
      raise "You can only add symbols F, W, and X to map"
    end
  end

  def remove_from_map(given_coords)
    @all_coords.delete(given_coords)
  end

  def to_s
    #upper_bound
    #lower_bound
    #left_bound
    #right_bound
  end
end