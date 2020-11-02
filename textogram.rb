# Textogram
# Raphael Adams

class Textogram
  attr_reader :input
  attr_reader :case_sensitive
  attr_reader :special_characters
  attr_reader :split_character

  def initialize(input, case_sensitive = "N", special_characters = "Y", numbers = "Y")
    @input = input.to_s
    @case_sensitive = verify_specs(case_sensitive)
    @special_characters = verify_specs(special_characters)
    @numbers = verify_specs(numbers)
  end

  def to_s
    # print the histogram, characters should be sorted
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