require './test/helper_test'
require './lib/night_writer'

class NightWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @night_writer = NightWriter.new
  end
  
  def test_it_exists
    assert_instance_of NightWriter, @night_writer
    assert_equal 'braille.txt', @night_writer.output_path
  end

  def test_it_can_read_input_file
    assert_instance_of String, @night_writer.read_input_file
  end

  def test_it_can_get_char_count_in_input_file
    @night_writer.stubs(:read_input_file).returns("This has characters!")
    assert_equal 20, @night_writer.read_input_file.length
  end

  def test_it_can_return_terminal_message
    @night_writer.stubs(:read_input_file).returns("This has characters!")
    assert_equal "Created 'braille.txt' containing 20 characters", @night_writer.terminal_message
  end

  def test_it_can_write_input_content_to_output_file
    @night_writer.stubs(:read_input_file).returns("This has characters!")
    @night_writer.write_input_content_to_output_file

    assert_equal "This has characters!", @night_writer.read_output_file
  end

  def test_it_can_translate_and_output_single_char_to_braille
    @night_writer.stubs(:read_input_file).returns("h")

    assert_equal "0.\n00\n..", @night_writer.translate_and_output_single_char_to_braille
  end

  def test_it_can_translate_and_output_multiple_char_to_braille
    @night_writer.stubs(:read_input_file).returns("ru")
    translation = "0.0.\n00..\n0.00"

    assert_equal translation, @night_writer.translate_and_output_multiple_char_to_braille
  end
end