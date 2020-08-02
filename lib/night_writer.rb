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

  def read_output_file 
    File.read(@output_path)
  end

  def terminal_message
    "Created '#{@output_path}' containing #{read_input_file.length} characters"
  end

  def write_input_content_to_output_file 
    File.open(@output_path, "w") { |f| f.write read_input_file  }
  end

  def translate_and_output_to_braille   
    translation = @translator.translate_to_braille(read_input_file)

    File.open(@output_path, "w") { |f| f.write translation }
    read_output_file
  end
end

# test = NightWriter.new  
# puts test.terminal_message
