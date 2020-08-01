class Translator
  attr_reader :char_map

  def initialize
    @char_map = Hash.new
    map_character_to_braille
  end

  def map_character_to_braille
    @char_map[: ] = " "
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

  def array_of_braille_for_chars(chars)
    chars.chars.map do |char|
      @char_map[char.to_sym]
    end.join
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

  # def column_headers(chars)
  #   chars.chars.map do |char|
  #     char_to_braille(char)[0..1]
  #   end.join
  # end

  def rows(chars)
    "#{@char_map[chars.chars[0].to_sym][0]}\n#{@char_map[chars.chars[0].to_sym][2]}\n#{@char_map[chars.chars[0].to_sym][4]}"
    # row_1 = "#{@char_map[chars.chars[0].to_sym][0]}\n"
    # row_2 = "#{@char_map[chars.chars[0].to_sym][2]}\n"
    # row_3 = "#{@char_map[chars.chars[0].to_sym][4]}"
  end

  def first_char_row_1(chars)
    "#{@char_map[chars.chars[0].to_sym][0]}"
  end

  def first_char_row_2(chars)
    "#{@char_map[chars.chars[0].to_sym][2]}"
  end

  def first_char_row_3(chars)
    "#{@char_map[chars.chars[0].to_sym][4]}"
  end

  def char_count(chars)
    chars.length
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
end