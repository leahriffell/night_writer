class NightWriter 
  attr_reader :output_path

  def initialize
    @input_path = ARGV[0]
    @output_path = ARGV[1]
  end

  def read_input_file 
    File.read(@input_path)
  end

  def input_content_length
    read_input_file.length
  end

  def terminal_message
    input_content_length
    "Created '#{@output_path}' containing #{input_content_length} characters"
  end
end

# test = NightWriter.new  
# puts test.terminal_message
