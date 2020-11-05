# Treasure Hunt
# Raphael Adams

class TreasureMap

  def initialize
    @all_coords = Hash.new(".")
  end

  public

  def add_to_map(given_coords, item)
    if ["F", "W", "X"].include?(item.upcase)
      @all_coords[given_coords] = item
    else
      raise "You can only add symbols F, W, and X to map"
    end
  end

  def remove_from_map(given_coords)
    @all_coords.delete(given_coords)
  end

  def to_s
    if @all_coords.empty? == false
    
      x_and_y_vals = @all_coords.keys.transpose

      upper_bound = x_and_y_vals.last.max
      left_bound = x_and_y_vals.first.min
      bottom_bound = x_and_y_vals.last.min
      right_bound = x_and_y_vals.first.max
    
      upper_bound.downto(bottom_bound).each do |j|
        (left_bound..right_bound).each do |i|
          print @all_coords[[i, j]]
        end
        print "\n"
      end
    
    else
      puts "Map is empty"
    end
  end
end

# # Quick test:
# test_map = TreasureMap.new
# test_map.add_to_map([0, 1], "F")
# test_map.add_to_map([11, 0], "F")
# test_map.add_to_map([6, -2], "W")
# test_map.add_to_map([-1, -5], "X")
# test_map.to_s