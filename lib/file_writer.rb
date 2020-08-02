class FileWriter
  attr_reader :output
  
  def initialize
    @output_path = ARGV[1]
    @output = File.read(@output_path)
  end

  def write(content)
    File.open(@output_path, "w") { |f| f.write content }
    @output
  end
end