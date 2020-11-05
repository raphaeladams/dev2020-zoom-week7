# Textogram
# Raphael Adams

class Textogram
  attr_reader :histogram_letters
  attr_reader :histogram_words

  def initialize(input, case_sensitive = false, incl_special_characters = true, incl_numbers = true)

    @input = input.to_s
    @case_sensitive = case_sensitive
    @incl_special_characters = incl_special_characters
    @incl_numbers = incl_numbers

    @input.downcase! unless @case_sensitive

    letters = filter(@input.split(//))
    words = filter(@input.split(" "))

    @histogram_letters = letters.tally
    @histogram_words = words.tally

  end

  public

  def to_s
    puts "\nLETTERS:"
    print_histogram(@histogram_letters)
    puts "\nWORDS:"
    print_histogram(@histogram_words)
  end

  private

  def filter(array)
    array.reject! { |i| i[/\s/] }
    array.reject! { |i| i[/\W/] } unless @incl_special_characters
    array.reject! { |i| i[/\d/] } unless @incl_numbers
    array
  end

  def print_histogram(hash)
    if hash.empty?
      puts "Nothing to print"
      return
    end

    print_list = hash.sort
    print_list.each do |i|
      print "#{ i.first } ".ljust(10)
      i.last.times { print "*" }
      print "\n"
    end
  end

end


# # Project Gutenberg test
# text = File.read("GreekBiology_Singer.txt").strip
# project_gutenberg_textogram = Textogram.new(text, false, false, false)
# puts project_gutenberg_textogram.histogram_letters
# puts project_gutenberg_textogram.histogram_words
# project_gutenberg_textogram.to_s
