# Textogram
# Raphael Adams

class Textogram
  attr_reader :input
  attr_reader :case_sensitive
  attr_reader :incl_special_characters
  attr_reader :incl_numbers
  attr_reader :histogram

  def initialize(input, case_sensitive = false, incl_special_characters = true, incl_numbers = true)

    @input = input.to_s
    @case_sensitive = case_sensitive
    @incl_special_characters = incl_special_characters
    @incl_numbers = incl_numbers

    @input.downcase! unless @case_sensitive
    @content_for_histogram = @input.split(//)

    @content_for_histogram.reject! { |i| i[/\s/] }
    @content_for_histogram.reject! { |i| i[/\W/] } unless @incl_special_characters
    @content_for_histogram.reject! { |i| i[/\d/] } unless @incl_numbers

    @histogram = Hash.new

    @content_for_histogram.each do |i|
      key = i.to_sym
      @histogram[key] == nil ? @histogram[key] = 1 : @histogram[key] += 1
    end
    @histogram

  end

  def to_s
    @printout = @histogram.sort
    @printout.each do |i|
      print "#{ i.first } "
      i.last.times { print "*" }
      print "\n"
    end
  end

end

# test_textogram = Textogram.new("HELLO World!", false, true, true)
# test_textogram.to_s
# puts "\n\n"

# test_textogram = Textogram.new("aoS!?ien2o3rn", true, true, false)
# test_textogram.to_s
# puts "\n\n"

# test_textogram = Textogram.new("", true, true, false)
# test_textogram.to_s
# puts "\n\n"