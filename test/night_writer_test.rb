require './test/helper_test'
require './lib/night_writer'

class NightWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @night_writer = NightWriter.new
    @night_writer.stubs(:read_input_file).returns("This has characters!")
  end
  
  def test_it_exists
    assert_instance_of NightWriter, @night_writer
    assert_equal 'braille.txt', @night_writer.output_path
  end

  def test_it_can_read_input_file
    assert_instance_of String, @night_writer.read_input_file
  end

  def test_it_can_get_char_count_in_input_file
    assert_equal 20, @night_writer.read_input_file.length
  end

  def test_it_can_return_terminal_message
    assert_equal "Created 'braille.txt' containing 20 characters", @night_writer.terminal_message
  end

  def test_it_can_write_input_content_to_output_file
    @night_writer.write_input_content_to_output_file

    assert_equal "This has characters!", @night_writer.read_output_file
  end
end