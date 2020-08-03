require './test/helper_test'
require './lib/translator'


class TranslatorTest < MiniTest::Test 

  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @translator = Translator.new
    create_reusable_variables_for_testing
  end

  def create_reusable_variables_for_testing 
    @four_hello_worlds_alpha_plain = "hello worldhello worldhello worldhello world"
    @four_hello_worlds_alpha_formatted = "hello worldhello worldhello worldhello w\norld"
    @four_hello_worlds_braille_formatted = "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0..."

    @abcs_alpha_formatted = "abcdefghijklmnopqrstuvwxyz"
    @abcs_braille_formatted = "0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000.\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.0\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000"

    @ruby_alpha_formatted = "ruby"
    @ruby_braille_formatted = "0.0.0.00\n00..0..0\n0.00..00"

    @ru_alpha_formatted = "ru"
    @ru_alpha_braille_formatted = "0.0.\n00..\n0.00"
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
    assert_equal [["0.000."], ["0...00"]], @translator.collection_of_braille_translations(@ru_alpha_formatted)
  end

  # ---- break into clusters ----

  def test_it_can_distinguish_alpha_from_braille
    assert_equal false, @translator.is_braille?(@ruby_alpha_formatted)
    assert_equal true, @translator.is_braille?(@ruby_braille_formatted)
  end

  def test_it_can_determine_max_chars_per_cluser
    assert_equal 40, @translator.max_chars_per_cluster(@ruby_alpha_formatted)
    assert_equal 243, @translator.max_chars_per_cluster(@ruby_braille_formatted)
  end

  def test_it_can_split_alpha_into_clusters
    assert_equal 2, @translator.split_alpha_into_clusters(@four_hello_worlds_alpha_plain).count
  end

  def test_it_can_split_braille_into_clusters
    assert_equal 2, @translator.split_braille_into_clusters(@four_hello_worlds_braille_formatted).count
  end

  # -----------------------------

  def test_it_can_translate_multi_chars_with_braille_formatting
    assert_equal @ruby_braille_formatted, @translator.render_rows_and_columns(@ruby_alpha_formatted)

    translation = @abcs_braille_formatted
    assert_equal translation, @translator.render_rows_and_columns(@abcs_alpha_formatted)
  end


  def test_it_can_translate_and_output_to_braille
    assert_equal @four_hello_worlds_braille_formatted, @translator.translate_to_braille(@four_hello_worlds_alpha_plain)
  end

  # translation to braille and output related methods 

  def test_it_can_translate_and_output_single_char_to_braille
    @translator.stubs(:read_input_file).returns("h")

    assert_equal "0.\n00\n..", @translator.translate_and_write_to_output
  end

  def test_it_can_translate_and_output_multiple_char_to_braille
    @translator.stubs(:read_input_file).returns(@ruby_alpha_formatted)

    assert_equal @ruby_braille_formatted, @translator.translate_and_write_to_output
  end

  def test_it_can_translate_and_output_multi_rows_to_braille
    @translator.stubs(:read_input_file).returns(@four_hello_worlds_alpha_plain)

    assert_equal @four_hello_worlds_braille_formatted, @translator.translate_and_write_to_output
  end

  # translation to alphabet and output related methods 

  def test_it_can_translate_single_alpha_to_braille
    assert_equal "h", @translator.braille_to_alpha("0.00..")
  end

  def test_it_can_return_collection_of_braille_arrays_by_row
    assert_equal ({@ru_alpha_braille_formatted => [["0.000."], ["0...00"]]}), @translator.collection_of_multi_row_braille_into_arrays_by_row(@ru_alpha_braille_formatted)
  end
  
  def test_it_can_return_long_collection_of_braille_arrays_by_row
    skip
    braille_arrays_by_row = {
      "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0" => [["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"]],

      "0.0.0.00\n.0000..0\n0.0.0..." => [["0..00."], ["0.000."], ["0.0.0."], ["00.0.."]]
    }

    assert_equal braille_arrays_by_row, @translator.collection_of_multi_row_braille_into_arrays_by_row(@four_hello_worlds_braille_formatted)
  end

  def test_it_can_translate_and_output_multiple_alpha_to_braille
    # skip
    assert_equal @ruby_alpha_formatted, @translator.translate_to_alpha(@ruby_braille_formatted)
  end


  def test_it_can_translate_and_multiple_alpha_to_braille
    assert_equal @four_hello_worlds_alpha_plain, @translator.translate_to_alpha(@four_hello_worlds_braille_formatted)
  end

  def test_it_can_translate_to_braille_and_line_wrap
    assert_equal @four_hello_worlds_alpha_formatted, @translator.translate_to_alpha_and_line_wrap(@four_hello_worlds_braille_formatted)
  end
end