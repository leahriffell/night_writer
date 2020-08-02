require './lib/file_reader'
require './lib/translator'
require './lib/row'

class NightWriter 
  attr_reader :output_path

  def initialize
    @output_path = ARGV[1]
    @input = FileReader.new
    @translator = Translator.new
  end

  def read_input_file 
    @input.input
  end

  def terminal_message
    "Created '#{@output_path}' containing #{read_input_file.length} characters"
  end

  def write_input_content_to_output_file 
    File.open(@output_path, "w") { |f| f.write read_input_file  }
  end

  def read_output_file 
    File.read(@output_path)
  end

  def translate_and_output_single_char_to_braille
    translation = @translator.char_to_braille_with_formatting(read_input_file)

    File.open(@output_path, "w") { |f| f.write translation }
    read_output_file
  end

  def translate_and_output_multiple_char_to_braille    
    split_into_rows.each_with_index do |row, index| 
      if (index != split_into_rows.length - 1) && (split_into_rows.length > 1)
        translation = @translator.render_rows_and_columns(row.text)
        File.open(@output_path, "a") { |f| f.write "#{translation}\n" }
      else 
        translation = @translator.render_rows_and_columns(row.text)
        File.open(@output_path, "a") { |f| f.write translation }
      end
    end
    read_output_file
  end

  def split_into_rows
    num_rows = (read_input_file.length/40.to_f).ceil
    range = (1..num_rows).to_a
    max_chars_per_row = 40
    index = 0
    rows = []
    range.each do |range|
      if range == num_rows
        rows << Row.new(read_input_file[index..-1])
      else 
        rows << Row.new(read_input_file[index..(index + max_chars_per_row - 1)])
      end
      index += max_chars_per_row
    end
    rows
  end
end

# test = NightWriter.new  
# puts test.terminal_message
