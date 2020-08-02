require './test/helper_test'
require './lib/file_reader'

class FileReaderTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @file_reader = FileReader.new
  end

  def test_it_exists 
    assert_instance_of FileReader, @file_reader
  end

  def test_it_can_be_read 
    assert_equal "", @file_reader.read
  end
end