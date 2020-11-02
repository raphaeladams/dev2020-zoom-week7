# Textogram
# Raphael Adams

require 'minitest/autorun'
require_relative '../textogram'

class TestHistogram < Minitest::Test
  def test_case_sensitivity
    test_textogram = Textogram.new("Hw")
    assert_equal test_textogram.histogram, { h: 1, w: 1 }

    test_textogram = Textogram.new("Hw", true)
    assert_equal test_textogram.histogram, { H: 1, w: 1 }

    test_textogram = Textogram.new("Hh")
    assert_equal test_textogram.histogram, { h: 2 }

    test_textogram = Textogram.new("Hh", true)
    assert_equal test_textogram.histogram, { H: 1, h: 1 }
  end

  def test_including_special_chars
    test_textogram = Textogram.new("Hw!", false, true)
    assert_equal test_textogram.histogram, { h: 1, w: 1, '!': 1 }
  end

  def test_rejecting_special_chars
    test_textogram = Textogram.new("Hw!", false, false)
    assert_equal test_textogram.histogram, { h: 1, w: 1 }
  end

  def test_including_numbers
    test_textogram = Textogram.new("Hw1", false, false, true)
    assert_equal test_textogram.histogram, { h: 1, w: 1, '1': 1 }
  end

  def test_rejecting_numbers
    test_textogram = Textogram.new("Hw1", false, false, false)
    assert_equal test_textogram.histogram, { h: 1, w: 1 }
  end

  def test_empty_strings
    test_textogram = Textogram.new("", false, false, false)
    assert_equal test_textogram.histogram, { }
  end

  def test_input_with_all_numbers
    test_textogram = Textogram.new(2013, false, false, true)
    assert_equal test_textogram.histogram, { '0': 1, '1': 1, '2': 1, '3': 1 }

    test_textogram = Textogram.new(2013, false, false, false)
    assert_equal test_textogram.histogram, { }
  end

  def test_input_with_all_symbols
    test_textogram = Textogram.new("?!*$", false, true)
    assert_equal test_textogram.histogram, { '?': 1, '!': 1, '*': 1, '$': 1 }

    test_textogram = Textogram.new("?!*$", false, false)
    assert_equal test_textogram.histogram, { }
  end
end