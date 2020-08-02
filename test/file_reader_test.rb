require './test/helper_test'
require './lib/file_reader'

class FileReaderTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @input = FileReader.new
  end

  def test_it_exists 
    assert_instance_of FileReader, @input
  end
end