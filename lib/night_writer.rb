class NightWriter 
  attr_reader :output_path

  def initialize
    @input_path = ARGV[0]
    @output_path = ARGV[1]
  end

  def read_input_file 
    File.read(@input_path)
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
end

# test = NightWriter.new  
# puts test.terminal_message
