class FileReader 
  attr_reader :input
  
  def initialize
    @input_path = ARGV[0]
  end

  def read
    File.read(@input_path)
  end
end