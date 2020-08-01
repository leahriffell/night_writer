require './test/helper_test'
require './lib/night_writer'

class NightWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @night_writer = NightWriter.new
    File.open(@night_writer.output_path, "w") { |f| f.write "" }
    File.open(@night_writer.input_path, "w") { |f| f.write "" }
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

    File.open(@night_writer.output_path, "w") { |f| f.write "" }
    @night_writer.stubs(:read_input_file).returns("hello world")

    assert_equal "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...", @night_writer.translate_and_output_multiple_char_to_braille
  end

  def test_it_can_split_into_rows
    @night_writer.stubs(:read_input_file).returns("hello worldhello worldhello worldhello world")

    assert_equal 2, @night_writer.split_into_rows.count
  end

  def test_it_can_translate_and_output_multi_rows_to_braille
    @night_writer.stubs(:read_input_file).returns("hello worldhello worldhello worldhello world")

    assert_equal "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...", @night_writer.translate_and_output_multiple_char_to_braille 
  end
end