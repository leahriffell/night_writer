require './test/helper_test'
require './lib/file_writer'

class FileWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @output = FileWriter.new
  end

  def test_it_exists 
    assert_instance_of FileWriter, @output
  end

  def test_it_can_be_written_to
    assert_equal "Four for you, Glenn Coco!", @output.write("Four for you, Glenn Coco!")
  end
end