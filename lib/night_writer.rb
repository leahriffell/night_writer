class NightWriter 
  attr_reader :output_file

  def initialize
    @input_file = ARGV[0]
    @output_file = ARGV[1]
  end

  def terminal_message
    "Created '#{@output_file}' containing 256 characters"
  end
end

test = NightWriter.new
p test.terminal_message