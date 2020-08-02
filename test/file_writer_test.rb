require './test/helper_test'
require './lib/file_writer'

class FileWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @file_writer = FileWriter.new
  end

  def test_it_exists 
    assert_instance_of FileWriter, @file_writer
  end

  def test_it_can_be_read 
    assert_equal "", @file_writer.read_file
  end

  def test_it_can_be_written_to
    @file_writer.write("Four for you, Glenn Coco!")

    assert_equal "Four for you, Glenn Coco!", @file_writer.read_file
  end
end