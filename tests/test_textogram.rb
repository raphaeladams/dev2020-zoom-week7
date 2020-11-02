# Textogram
# Raphael Adams

require 'minitest/autorun'
require_relative '../textogram'

class TestHistogram < Minitest::Test
  def test_case_sensitivity
    test_textogram = Textogram.new("Hw")
    assert_equal test_textogram.histogram_letters, { h: 1, w: 1 }

    test_textogram = Textogram.new("Hw", true)
    assert_equal test_textogram.histogram_letters, { H: 1, w: 1 }

    test_textogram = Textogram.new("Hh")
    assert_equal test_textogram.histogram_letters, { h: 2 }

    test_textogram = Textogram.new("Hh", true)
    assert_equal test_textogram.histogram_letters, { H: 1, h: 1 }
  end

  def test_including_special_chars
    test_textogram = Textogram.new("Hw!", false, true)
    assert_equal test_textogram.histogram_letters, { h: 1, w: 1, '!': 1 }
  end

  def test_rejecting_special_chars
    test_textogram = Textogram.new("Hw!", false, false)
    assert_equal test_textogram.histogram_letters, { h: 1, w: 1 }
  end

  def test_including_numbers
    test_textogram = Textogram.new("Hw1", false, false, true)
    assert_equal test_textogram.histogram_letters, { h: 1, w: 1, '1': 1 }
  end

  def test_rejecting_numbers
    test_textogram = Textogram.new("Hw1", false, false, false)
    assert_equal test_textogram.histogram_letters, { h: 1, w: 1 }
  end

  def test_empty_strings
    test_textogram = Textogram.new("", false, false, false)
    assert_equal test_textogram.histogram_letters, { }
  end

  def test_input_with_all_numbers
    test_textogram = Textogram.new(2013, false, false, true)
    assert_equal test_textogram.histogram_letters, { '0': 1, '1': 1, '2': 1, '3': 1 }

    test_textogram = Textogram.new(2013, false, false, false)
    assert_equal test_textogram.histogram_letters, { }
  end

  def test_input_with_all_symbols
    test_textogram = Textogram.new("?!*$", false, true)
    assert_equal test_textogram.histogram_letters, { '?': 1, '!': 1, '*': 1, '$': 1 }

    test_textogram = Textogram.new("?!*$", false, false)
    assert_equal test_textogram.histogram_letters, { }
  end
end


class TestOutput < Minitest::Test
  def test_no_case_sensitivity_and_a_symbol
    test_textogram = Textogram.new("HELLO World!", false, true, true)
    assert_output(/!\s+\* | d\s+\* | e\s+\* | h\s+\* | l\s+\*\*\* | o\s+\*\* | r\s+\* | w\s+\*/x) { test_textogram.to_s }
    assert_output(/ hello\s+\*  |  world!\s+\* /x) { test_textogram.to_s }
  end

  def test_case_sensitivity_and_symbols_and_no_numbers
    test_textogram = Textogram.new("aS!?2o3rn", true, true, false)
    assert_output(/!\s+\* | \?\s+\* | S\s+\* | a\s+\* | n\s+\*\* | o\s+\*\* | r\s+\*/x) { test_textogram.to_s }
    assert_output(/WORDS:\nNothing to print/) { test_textogram.to_s }
  end

  def test_case_sensitivity_and_symbols_and_numbers
    test_textogram = Textogram.new("aS!?2o3r", true, true, true)
    assert_output(/!\s+\* | 2\s+\* | 3\s+\* | \?\s+\* | S\s+\* | a\s+\* | o\s+\*\* | r\s+\*/x) { test_textogram.to_s }
    assert_output(/ aS!\?2o3r\s+\* /x) { test_textogram.to_s }
  end

  def test_empty_string
    test_textogram = Textogram.new("", true, true, false)
    assert_output(/LETTERS:\nNothing to print\n\nWORDS:\nNothing to print/) { test_textogram.to_s }
  end
end