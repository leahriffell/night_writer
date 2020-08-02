require './lib/file_reader'
require './lib/file_writer'
require './lib/translator'
require './lib/row'

class NightWriter 
  attr_reader :input, :output, :output_path, :input_path, :translator

  def initialize
    @output_path = ARGV[1]
    @input_path = ARGV[0]
    @input = FileReader.new
    @output = FileWriter.new
    @translator = Translator.new
  end

  def read_input_file 
    @input.read
  end

  def read_output_file 
    @output.read
  end

  def terminal_message
    "Created '#{@output_path}' containing #{read_input_file.length} characters"
  end

  def translate_to_braille   
    translation = @translator.translate_to_braille(read_input_file)
  end

  def translate_and_write_to_output
    @output.write(translate_to_braille)
    read_output_file
  end
end

# test = NightWriter.new  
# puts test.terminal_message
