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

  def test_it_can_write_to_output_file
    @translator.write_to_output("hola")
    assert_equal "hola", @translator.read_output_file
  end

  def test_it_can_return_terminal_message
    @translator.stubs(:read_input_file).returns(@ruby_alpha_formatted)
    @translator.translate_to_braille_and_write_to_output
    # each new line char will count as 1 in the length ("ruby" has 2)
    assert_equal "Created 'braille.txt' containing 26 characters", @translator.terminal_message

    @translator.stubs(:read_input_file).returns(@ruby_braille_formatted)
    @translator.translate_to_alpha_and_write_to_output
    assert_equal "Created 'braille.txt' containing 4 characters", @translator.terminal_message
  end

  # ---- translate single char ----
  def test_it_can_distinguish_alpha_from_braille
    assert_equal false, @translator.is_braille?(@ruby_alpha_formatted)
    assert_equal true, @translator.is_braille?(@ruby_braille_formatted)
  end

  def test_it_can_translate_single_char
    assert_equal "0.....", @translator.translate_char("a")
    assert_equal "0.00..", @translator.translate_char("h")
    assert_equal "h", @translator.translate_char("0.00..")
  end

  # ---- break into clusters ----

  def test_it_can_determine_max_chars_per_cluser
    assert_equal 40, @translator.max_chars_per_cluster(@ruby_alpha_formatted)
    assert_equal 243, @translator.max_chars_per_cluster(@ruby_braille_formatted)
  end

  def test_it_can_split_into_clusters
    assert_equal 2, @translator.split_into_clusters(@four_hello_worlds_alpha_plain).count
    assert_equal 2, @translator.split_into_clusters(@four_hello_worlds_braille_formatted).count
  end

  # ---- translate alpha to braille ----
  
  def test_it_can_return_collection_of_braille_translations
    assert_equal [["0.000."], ["0...00"]], @translator.collection_of_braille_translations(@ru_alpha_formatted)
  end

  def test_it_can_add_to_rows_and_columns_to_translated_braille
    assert_equal @ruby_braille_formatted, @translator.add_rows_and_columns(@ruby_alpha_formatted)

    translation = @abcs_braille_formatted
    assert_equal translation, @translator.add_rows_and_columns(@abcs_alpha_formatted)
  end


  def test_it_can_translate_to_braille
    assert_equal @four_hello_worlds_braille_formatted, @translator.translate_to_braille(@four_hello_worlds_alpha_plain)

    assert_equal @abcs_braille_formatted, @translator.translate_to_braille(@abcs_alpha_formatted)
  end

  def test_it_can_translate_to_braille_and_write_to_output
    @translator.stubs(:read_input_file).returns(@ruby_alpha_formatted)

    assert_equal @ruby_braille_formatted, @translator.translate_to_braille_and_write_to_output

    @translator.stubs(:read_input_file).returns(@four_hello_worlds_alpha_plain)

    assert_equal @four_hello_worlds_braille_formatted, @translator.translate_to_braille_and_write_to_output
  end

  # ---- translate braille to alpha ---- 

  def test_it_can_return_collection_of_braille_arrays_by_row
    assert_equal ({@ru_alpha_braille_formatted => [["0.000."], ["0...00"]]}), @translator.collection_of_braille_arrays_by_row(@ru_alpha_braille_formatted)

    # braille_arrays_by_row = {
    #   "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0" => [["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"]], "0.0.0.00\n.0000..0\n0.0.0..." => [["0..00."], ["0.000."], ["0.0.0."], ["00.0.."]]
    # }
    # assert_equal braille_arrays_by_row, @translator.collection_of_braille_arrays_by_row(@four_hello_worlds_braille_formatted)
  end

  def test_it_can_translate_to_alpha
    assert_equal @ruby_alpha_formatted, @translator.translate_to_alpha(@ruby_braille_formatted)
    
    assert_equal @four_hello_worlds_alpha_plain, @translator.translate_to_alpha(@four_hello_worlds_braille_formatted)
    
    assert_equal @abcs_alpha_formatted, @translator.translate_to_alpha(@abcs_braille_formatted)
  end

  def test_it_can_line_wrap_alpha
    assert_equal @four_hello_worlds_alpha_formatted, @translator.translate_to_alpha_and_line_wrap(@four_hello_worlds_braille_formatted)

    assert_equal @abcs_alpha_formatted, @translator.translate_to_alpha_and_line_wrap(@abcs_braille_formatted)
  end


  def test_it_can_translate_to_alpha_and_write_to_output
    @translator.stubs(:read_input_file).returns(@ruby_braille_formatted)

    @translator.translate_to_alpha_and_write_to_output

    assert_equal @ruby_alpha_formatted, @translator.read_output_file
  end
end