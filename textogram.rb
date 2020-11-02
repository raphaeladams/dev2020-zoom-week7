# Textogram
# Raphael Adams

class Textogram
  attr_reader :input
  attr_reader :case_sensitive
  attr_reader :incl_special_characters
  attr_reader :split_character

  def initialize(input, case_sensitive = "N", incl_special_characters = "Y", incl_numbers = "Y")

    @input = input.to_s
    @case_sensitive = verify_specs(case_sensitive)
    @incl_special_characters = verify_specs(incl_special_characters)
    @incl_numbers = verify_specs(incl_numbers)

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
    
  end

  def to_s
    # print the histogram, characters should be sorted
    @printout = @histogram.sort
    @printout.each do |i|
      print "#{ i.first } "
      i.last.times { print "*" }
      print "\n"
    end
  end

  def verify_specs(specification)
    if specification.upcase == "Y"
      true
    elsif specification.upcase == "N"
      false
    else
      raise "Must enter 'Y' or 'N' for all specifications"
    end
  end

end

test_textogram = Textogram.new("HELLO World!", "N", "Y", "Y")#("aoS!?ien2o3rn", "Y", "Y", "Y")
test_textogram.to_s
puts "\n"