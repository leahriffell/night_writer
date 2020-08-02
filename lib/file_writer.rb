class FileWriter
  attr_reader :output
  
  def initialize
    @output_path = ARGV[1]
    @output = File.new(@output_path, "w")
  end

  def read_file 
    File.read(@output)
  end

  def write(content)
    File.write(@output_path, content)
  end
end