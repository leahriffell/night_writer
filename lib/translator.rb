require './lib/row'
require './lib/dictionary'

class Translator
  attr_reader :char_map

  def initialize
    @dictionary = Dictionary.new
  end

  def char_to_braille(char)
    @dictionary.char_map[char.to_sym]
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

  def split_into_rows(chars)
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

    split_into_rows(chars).each_with_index do |row, index| 
      if (index != split_into_rows(chars).length - 1) && (split_into_rows(chars).length > 1)
        translation = render_rows_and_columns(row.text)
        result << "#{translation}\n"
      else 
        translation = render_rows_and_columns(row.text)
        result << translation
      end
    end
    result
  end
end