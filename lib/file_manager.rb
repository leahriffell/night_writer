class FileManager
  attr_reader :file_path 
  
  def initialize(file_path, type = "input")
    @file_path = file_path
    File.new(@file_path, "w") if type == "output"
  end

  def read
    File.read(@file_path)
  end

  def write(content)
    File.write(@file_path, content)
  end
end