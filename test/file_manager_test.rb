require './test/helper_test'
require './lib/file_manager'

class FileReaderTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @input = FileManager.new(ARGV[0])
    @output = FileManager.new(ARGV[1], 'output')
  end

  def test_it_exists
    assert_instance_of FileManager, @input
  end

  def test_it_has_readable_attributes 
    assert_equal 'message.txt', @input.file_path
    assert_equal 'braille.txt', @output.file_path
  end

  def test_it_can_be_written_to
    assert_equal 23, @input.write('four for you glenn coco')
    assert_equal 11, @output.write('free barron')
  end

  def test_it_can_be_read
    @input.write('four for you glenn coco')
    assert_equal 'four for you glenn coco', @input.read

    @output.write('free barron')
    assert_equal 'free barron', @output.read
  end
end
