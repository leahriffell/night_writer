require './lib/file_reader'
require './lib/file_writer'
require './lib/dictionary'
require './lib/cluster'

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

  def collection_of_braille_translations(alpha)
    collection = []
    alpha.chars.each do |alpha|
      translation = []
      translation << translate_char(alpha)
      collection << translation
    end
    collection
  end

  # ---- break into clusters ----

  def max_chars_per_cluster(content)
    if is_braille?(content)
      max_chars_per_cluster = 243
    else 
      max_chars_per_cluster = 40 
    end
    max_chars_per_cluster
  end 

  def split_into_clusters(content)
    cluster_range = (1..(content.length/max_chars_per_cluster(content).to_f).ceil).to_a

    index = 0
    cluster_range.reduce([]) do |result, cluster|
      if cluster == cluster_range.last
        result << Cluster.new(content[index..-1])
      else 
        result << Cluster.new(content[index..(index + max_chars_per_cluster(content) - 1)])
      end
      index += max_chars_per_cluster(content)
      result
    end
  end

  # -----------------------------

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

  def translate_to_braille(alpha)  
    result = ""

    split_into_clusters(alpha).each_with_index do |row, index| 
      if (index != split_into_clusters(alpha).length - 1) && (split_into_clusters(alpha).length > 1)
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

  def collection_of_braille_arrays_by_row(braille) 
    split_into_clusters(braille).reduce({}) do |result, cluster|
        index = 0 
        strings = []
        (cluster.text.gsub("\n", "").length/6).times do 
          strings << cluster.text.split("\n").map do |sub_row| 
            sub_row[index..(index + 1)]
          end.join
          index += 2
        end 
        string_array = strings.map do |string|
          a = []
          a << string
        end
      result[cluster.text] = string_array
      result
    end
  end

  def translate_to_alpha(braille)
    collection_of_braille_arrays_by_row(braille).values.flatten.map do |braille_str|
      translate_char(braille_str)
    end.join
  end

  def translate_to_alpha_and_line_wrap(braille)
    @output.write(translate_to_alpha(braille).scan(/.{1,40}/).join("\n"))
    read_output_file
  end
end