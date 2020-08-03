require './test/helper_test'
require './lib/translator'

class TranslatorTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @translator = Translator.new
  end

  def test_it_exists
    assert_instance_of Translator, @translator
  end

  def test_it_can_read_input_file
    assert_instance_of String, @translator.read_input_file
  end

  def test_it_can_read_output_file
    assert_instance_of String, @translator.read_input_file
  end

  def test_it_can_write_input_to_output_file
    @translator.stubs(:read_input_file).returns("hola")
    @translator.write_input_to_output 

    assert_equal "hola", @translator.read_output_file
  end

  def test_it_can_return_terminal_message
    @translator.stubs(:read_input_file).returns("This has characters!")

    assert_equal "Created 'braille.txt' containing 20 characters", @translator.terminal_message
  end

  def test_it_can_lookup_braille_for_character
    assert_equal "0......", @translator.char_to_braille("a")
    assert_equal "0.00..", @translator.char_to_braille("h")
  end

  def test_it_can_return_collection_of_braille_translations
    assert_equal [["0.000."], ["0...00"]], @translator.collection_of_braille_translations("ru")
  end

  def test_it_can_split_alpha_into_rows
    assert_equal 2, @translator.split_alpha_into_rows("hello worldhello worldhello worldhello world").count
  end

  def test_it_can_translate_multi_chars_with_braille_formatting
    assert_equal "0.0.0.00\n00..0..0\n0.00..00", @translator.render_rows_and_columns("ruby")

    translation = "0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000.\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.0\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000"
    assert_equal translation, @translator.render_rows_and_columns("abcdefghijklmnopqrstuvwxyz")
  end


  def test_it_can_translate_and_output_to_braille
    assert_equal "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...", @translator.translate_to_braille("hello worldhello worldhello worldhello world")
  end

  # translation to braille and output related methods 

  def test_it_can_translate_and_output_single_char_to_braille
    @translator.stubs(:read_input_file).returns("h")

    assert_equal "0.\n00\n..", @translator.translate_and_write_to_output
  end

  def test_it_can_translate_and_output_multiple_char_to_braille
    @translator.stubs(:read_input_file).returns("ruby")

    assert_equal "0.0.0.00\n00..0..0\n0.00..00", @translator.translate_and_write_to_output
  end

  def test_it_can_translate_and_output_multi_rows_to_braille
    @translator.stubs(:read_input_file).returns("hello worldhello worldhello worldhello world")

    assert_equal "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...", @translator.translate_and_write_to_output
  end

  # translation to alphabet and output related methods 

  def test_it_can_translate_single_alpha_to_braille
    assert_equal "h", @translator.braille_to_alpha("0.00..")
  end

  def test_it_can_split_braille_into_rows 
    assert_equal 2, @translator.split_braille_into_rows("0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...").count
  end

  def test_it_can_return_collection_of_braille_arrays_by_row
    # skip
    #the braille below translates to "ru". The hash key is the braille as it's meant to print to file. 
    assert_equal ({"0.0.\n00..\n0.00" => [["0.000."], ["0...00"]]}), @translator.collection_of_multi_row_braille_into_arrays_by_row("0.0.\n00..\n0.00")
  end
  
  def test_it_can_return_long_collection_of_braille_arrays_by_row
    skip
    braille_arrays_by_row = {
      "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0" => [["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"]],

      "0.0.0.00\n.0000..0\n0.0.0..." => [["0..00."], ["0.000."], ["0.0.0."], ["00.0.."]]
    }

    assert_equal braille_arrays_by_row, @translator.collection_of_multi_row_braille_into_arrays_by_row("0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...")
    #braille above is how it's printed, not just a string of all of them
  end

  def test_it_can_translate_and_output_multiple_alpha_to_braille
    # skip
    assert_equal "ruby", @translator.translate_to_alpha("0.0.0.00\n00..0..0\n0.00..00")
  end


  def test_it_can_translate_and_multiple_alpha_to_braille
    assert_equal "hello worldhello worldhello worldhello world", @translator.translate_to_alpha("0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...")
  end

  def test_it_can_translate_to_braille_and_line_wrap
    assert_equal "hello worldhello worldhello worldhello w\norld", @translator.translate_to_alpha_and_line_wrap("0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...")
  end
end