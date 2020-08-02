require './lib/row'

class Translator
  attr_reader :char_map

  def initialize
    @char_map = Hash.new
    map_character_to_braille
  end

  def map_character_to_braille
    @char_map[:" "] = "......"
    @char_map[:a] = "0......"
    @char_map[:b] = "0.0..."
    @char_map[:c] = "00...."
    @char_map[:d] = "00.0.."
    @char_map[:e] = "0..0.."
    @char_map[:f] = "000..."
    @char_map[:g] = "0000.."
    @char_map[:h] = "0.00.."
    @char_map[:i] = ".00..."
    @char_map[:j] = ".000.."
    @char_map[:k] = "0...0."
    @char_map[:l] = "0.0.0."
    @char_map[:m] = "00..0."
    @char_map[:n] = "00.00."
    @char_map[:o] = "0..00."
    @char_map[:p] = "000.0."
    @char_map[:q] = "00000."
    @char_map[:r] = "0.000."
    @char_map[:s] = ".00.0."
    @char_map[:t] = ".0000."
    @char_map[:u] = "0...00"
    @char_map[:v] = "0.0.00"
    @char_map[:w] = ".000.0"
    @char_map[:x] = "00..00"
    @char_map[:y] = "00.000"
    @char_map[:z] = "0..000"
  end

  def convert_to_multi_line(braille)
    "#{braille[0]}" + "#{braille[1]}\n" +
    "#{braille[2]}" + "#{braille[3]}\n" +
    "#{braille[4]}" + "#{braille[5]}"
  end

  def char_to_braille_with_formatting(char)
    convert_to_multi_line(@char_map[char.to_sym])
  end

  def collection_of_braille_translations(chars)
    collection = []
    chars.chars.each do |char|
      translation = []
      translation << @char_map[char.to_sym]
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