require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require './lib/row'

class Translator
  attr_reader :char_map

  def initialize
    @dictionary = Dictionary.new
    @output_path = ARGV[1]
    @input_path = ARGV[0]
    @input = FileReader.new
    @output = FileWriter.new
  end

  def read_input_file 
    @input.read
  end

  def read_output_file 
    @output.read
  end

  def write_input_to_output
    @output.write(read_input_file)
  end

  def terminal_message
    "Created '#{@output_path}' containing #{read_input_file.length} characters"
  end

  def char_to_braille(char)
    @dictionary.char_map[char]
  end

  def collection_of_braille_translations(chars)
    collection = []
    chars.chars.each do |char|
      translation = []
      translation << char_to_braille(char)
      collection << translation
    end
    collection
  end

  def split_alpha_into_rows(chars)
    num_rows = (chars.length/40.to_f).ceil
    range = (1..num_rows).to_a
    max_chars_per_row = 40
    index = 0
    rows = []
    range.each do |range|
      if range == num_rows
        rows << Row.new(chars[index..-1])
      else 
        rows << Row.new(chars[index..(index + max_chars_per_row - 1)])
      end
      index += max_chars_per_row
    end
    rows
  end

  def render_rows_and_columns(chars)
    row_1 = ""
    row_2 = ""
    row_3 = ""

    collection_of_braille_translations(chars).each do |translation|
      row_1 << translation[0][0..1]
      row_2 << translation[0][2..3]
      row_3 << translation[0][4..5]
    end
    
    "#{row_1}\n#{row_2}\n#{row_3}" 
  end 

  def translate_to_braille(chars)  
    result = ""

    split_alpha_into_rows(chars).each_with_index do |row, index| 
      if (index != split_alpha_into_rows(chars).length - 1) && (split_alpha_into_rows(chars).length > 1)
        translation = render_rows_and_columns(row.text)
        result << "#{translation}\n"
      else 
        translation = render_rows_and_columns(row.text)
        result << translation
      end
    end
    result
  end

  def translate_and_write_to_output
    @output.write(translate_to_braille(read_input_file))
    read_output_file
  end

  #  methods for converting braille to alpha 

  def braille_to_alpha(braille)
    @dictionary.char_map.invert[braille]
  end

  def split_braille_into_rows(braille)
    # num_rows = (braille.gsub("\n", "").length/240.to_f).ceil
    # each cluster/row will have three new line chars which each count as 1 in ruby. This is why it's changed to 243 below. 
    num_rows = (braille.length/243.to_f).ceil
    range = (1..num_rows).to_a
    max_chars_per_row_grouping = 243
    index = 0
    rows = []
    range.each do |range|
      if range == num_rows
        rows << Row.new(braille[index..-1])
      else 
        rows << Row.new(braille[index..(index + max_chars_per_row_grouping - 1)])
      end
      index += max_chars_per_row_grouping
    end
    rows
  end

  def collection_of_multi_row_braille_into_arrays_by_row(braille) 
    # require 'pry'; binding.pry   
    split_braille_into_rows(braille).reduce({}) do |result, row|
        index = 0 
        strings = []
        (row.text.gsub("\n", "").length/6).times do 
          strings << row.text.split("\n").map do |sub_row| 
            sub_row[index..(index + 1)]
            # require 'pry'; binding.pry if poop.nil? 
            # poop
          end.join
          index += 2
        end 
        string_array = strings.map do |string|
          a = []
          a << string
        end
      result[row.text] = string_array
      result
    end
  end

  def translate_to_alpha(braille)
    collection_of_multi_row_braille_into_arrays_by_row(braille).values.flatten.map do |braille_str|
      braille_to_alpha(braille_str)
    end.join
  end

  def translate_and_line_wrap(braille)
    translate_to_alpha(braille).scan(/.{1,40}/).join("\n")
  end
end