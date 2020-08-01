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
    @night_writer.stubs(:read_input_file).returns("ruby")

    assert_equal "0.0.0.00\n00..0..0\n0.00..00", @night_writer.translate_and_output_multiple_char_to_braille
  end

  def test_it_can_split_into_rows
    @night_writer.stubs(:read_input_file).returns("Seven am waking up in the morning Gotta be fresh, gotta go downstairs Gotta have my bowl gotta have cereal Seein everything the time is goin Tickin on and on evrybodys rushin Gotta get down to the bus stop")

    assert_equal 3, @night_writer.split_into_rows.count
  end
end