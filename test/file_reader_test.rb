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

  def test_it_can_be_written_to
    assert_equal "Four for you, Glenn Coco!", @input.write("Four for you, Glenn Coco!")
  end
end