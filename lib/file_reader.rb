class FileReader 
  attr_reader :input
  
  def initialize
    @input_path = ARGV[0]
    @input = File.read(@input_path)
  end
end