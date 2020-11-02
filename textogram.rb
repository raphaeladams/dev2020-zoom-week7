# Textogram
# Raphael Adams

class Textogram
  attr_reader :input
  attr_reader :case_sensitive
  attr_reader :incl_special_characters
  attr_reader :incl_numbers
  attr_reader :histogram_letters
  attr_reader :histogram_words

  def initialize(input, case_sensitive = false, incl_special_characters = true, incl_numbers = true)

    @input = input.to_s
    @case_sensitive = case_sensitive
    @incl_special_characters = incl_special_characters
    @incl_numbers = incl_numbers

    @input.downcase! unless @case_sensitive

    @histogram_letters = generate_histogram(@input.split(//))
    @histogram_words = generate_histogram(@input.split(" "))

  end

  public

  def to_s
    puts "\nLETTERS:"
    print_histogram(@histogram_letters)
    puts "\nWORDS:"
    print_histogram(@histogram_words)
  end

  private

  def generate_histogram(array)
    array.reject! { |i| i[/\s/] }
    array.reject! { |i| i[/\W/] } unless @incl_special_characters
    array.reject! { |i| i[/\d/] } unless @incl_numbers

    histogram = Hash.new

    array.each do |i|
      key = i.to_sym
      histogram[key] == nil ? histogram[key] = 1 : histogram[key] += 1
    end
    
    histogram
  end

  def print_histogram(array)
    if array.empty?
      puts "Nothing to print"
      return
    end

    printout = array.sort
    printout.each do |i|
      print "#{ i.first } ".ljust(10)
      i.last.times { print "*" }
      print "\n"
    end
  end

end


project_gutenberg_textogram = Textogram.new(File.read("GreekBiology_Singer.txt").strip, false, false, false)
puts project_gutenberg_textogram.histogram_letters
puts project_gutenberg_textogram.histogram_words
project_gutenberg_textogram.to_s