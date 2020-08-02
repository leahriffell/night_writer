class FileReader 
  def initialize
    @input_path = ARGV[0]
    File.read(@input_path)
  end
end