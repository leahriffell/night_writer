class FileReader 
  attr_reader :input
  
  def initialize
    @input_path = ARGV[0]
    @input = File.read(@input_path)
  end

  def write(content)
    File.open(@input_path, "w") { |f| f.write content }
    @input
  end
end