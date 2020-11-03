# Textogram
# Raphael Adams

require 'minitest/autorun'
require_relative '../textogram'

class TextogramTest < Minitest::Test
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