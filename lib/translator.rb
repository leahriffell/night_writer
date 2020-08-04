require './lib/file_manager'
require './lib/dictionary'
require './lib/cluster'
require './lib/formatter'

class Translator
  def initialize
    @input = FileManager.new(ARGV[0])
    @output = FileManager.new(ARGV[1], "output")
    @dictionary = Dictionary.new
    @formatter = Formatter.new
  end

  def read_input_file 
    @input.read
  end

  def read_output_file 
    @output.read
  end

  def write_to_output(content)
    @output.write(content)
  end

  def terminal_message
    "Created '#{@output.file_path}' containing #{read_output_file.length} characters"
  end

   # ---- translate single char ----

  def is_braille?(content)
    if content.gsub("\n", "").chars.all? {|char| @dictionary.braille_characters.include?(char)}
      true
    else content.gsub("\n", "").chars.all? {|char| @dictionary.char_map.keys.include?(char)}
      false
    end
  end

  def translate_char(char)
    if is_braille?(char)
      @dictionary.char_map.invert[char]
    else 
      @dictionary.char_map[char]
    end
  end

  # ---- translate alpha to braille ----

  def collection_of_braille_translations(alpha)
    collection = []
    alpha.chars.each do |alpha|
      translation = []
      translation << translate_char(alpha)
      collection << translation
    end
    collection
  end

  def add_rows_and_columns(chars)
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

  def translate_to_braille(alpha)  
    result = ""

    @formatter.split_into_clusters(alpha).each_with_index do |row, index| 
      if index + 1 == @formatter.last_cluster(alpha)
        translation = add_rows_and_columns(row.text)
        result << translation
      else 
        translation = add_rows_and_columns(row.text)
        result << "#{translation}\n"
      end
    end
    result
  end

  def translate_to_braille_and_write_to_output
    write_to_output(translate_to_braille(read_input_file.gsub("\\n", "")))
  end

  # ---- translate braille to alpha ----

  def translate_to_alpha(braille)
    @formatter.braille_arrays_by_cluster_by_subrow(braille).values.flatten.map do |braille_str|
      translate_char(braille_str)
    end.join
  end

  def translate_to_alpha_and_line_wrap(braille)
    @formatter.line_wrap_alpha(translate_to_alpha(braille))
  end

  def translate_to_alpha_and_write_to_output
    write_to_output(translate_to_alpha_and_line_wrap(read_input_file.gsub("\\n", "\n")))   
  end
end