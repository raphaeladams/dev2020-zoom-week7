# Treasure Hunt
# Raphael Adams

require 'minitest/autorun'
require_relative '../treasure_map'

class TestTreasureMap < Minitest::Test
  def setup
    @test_map = TreasureMap.new
    @test_map.add_to_map([0, 1], "W")
    @test_map.add_to_map([1, 0], "F")
    @test_map.add_to_map([1, 1], "X")
  end

  def test_print_filled_map
    assert_output("WX\n.F\n") { @test_map.to_s }
  end

  def test_print_empty_map
    empty_map = TreasureMap.new
    assert_output("Map is empty\n") { empty_map.to_s }
  end

  def test_add_remove_food
    @test_map.add_to_map([0, 0], "F")
    assert_output("WX\nFF\n") { @test_map.to_s }
    @test_map.remove_from_map([0, 0])
    assert_output("WX\n.F\n") { @test_map.to_s }
  end

  def test_add_remove_water
    @test_map.add_to_map([0, 0], "W")
    assert_output("WX\nWF\n") { @test_map.to_s }
    @test_map.remove_from_map([0, 0])
    assert_output("WX\n.F\n") { @test_map.to_s }
  end

  def test_add_remove_treasure
    @test_map.add_to_map([0, 0], "X")
    assert_output("WX\nXF\n") { @test_map.to_s }
    @test_map.remove_from_map([0, 0])
    assert_output("WX\n.F\n") { @test_map.to_s }
  end

  def test_add_invalid
    assert_raises("You can only add symbols F, W, and X to map") { @test_map.add_to_map([0, 0], "B") }
  end
end
