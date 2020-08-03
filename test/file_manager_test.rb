require './test/helper_test'
require './lib/file_manager'

class FileReaderTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @input = FileManager.new(ARGV[0], "input")
    @output = FileManager.new(ARGV[1], "output")
  end

  def test_it_exists
    assert_instance_of FileManager, @input
  end

  def test_it_has_readable_attributes 
    assert_equal 'message.txt', @input.file_path
    assert_equal 'braille.txt', @output.file_path
  end

  def test_it_can_be_written_to
    assert_equal 25, @input.write("Four for you, Glenn Coco!")
    assert_equal 27, @output.write("There's a snake in my boot!")
  end

  def test_it_can_be_read 
    @input.write("Four for you, Glenn Coco!")
    assert_equal "Four for you, Glenn Coco!", @input.read

    @output.write("There's a snake in my boot!")
    assert_equal "There's a snake in my boot!",@output.read
  end
end