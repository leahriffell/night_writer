class FileManager
  attr_reader :file_path 
  
  def initialize(file_path, type)
    @file_path = file_path

    if type == "output"
      File.new(@file_path, "w")
    end 
  end

  def read
    File.read(@file_path)
  end

  def write(content)
    File.write(@file_path, content)
  end
end