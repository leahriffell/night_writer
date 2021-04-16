require './test/helper_test'
require './lib/translator'
require './test/fixtures/translation_library'

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

  def test_it_can_write_to_output_file
    @translator.write_to_output('hola')
    assert_equal 'hola', @translator.read_output_file
  end

  def test_it_can_return_terminal_message
    @translator.stubs(:read_input_file).returns(TranslationLibrary.ruby_alpha_formatted)
    @translator.translate_to_braille_and_write_to_output
    # each new line char will count as 1 in the length ("ruby" has 2)
    assert_equal "Created 'braille.txt' containing 26 characters", @translator.terminal_message

    @translator.stubs(:read_input_file).returns(TranslationLibrary.ruby_braille_formatted)
    @translator.translate_to_alpha_and_write_to_output
    assert_equal "Created 'braille.txt' containing 4 characters", @translator.terminal_message
  end

  # ---- translate single char ----

  def test_it_can_return_individual_chars
    assert_equal ['r', 'u', 'b', 'y'], @translator.individual_chars(TranslationLibrary.ruby_alpha_formatted) 
  end

  def test_it_can_distinguish_alpha_from_braille
    assert_equal false, @translator.is_braille?(TranslationLibrary.ruby_alpha_formatted)
    assert_equal true, @translator.is_braille?(TranslationLibrary.ruby_braille_formatted)
  end

  def test_it_can_translate_single_char
    assert_equal '0.....', @translator.translate_char('a')
    assert_equal '0.00..', @translator.translate_char('h')
    assert_equal 'h', @translator.translate_char('0.00..')
  end

  # ---- translate alpha to braille ----

  def test_it_can_return_collection_of_braille_translations
    assert_equal [['0.000.'], ['0...00']], @translator.collection_of_braille_translations(TranslationLibrary.ru_alpha_formatted)
  end

  def test_it_can_add_to_rows_and_columns_to_translated_braille
    assert_equal TranslationLibrary.ruby_braille_formatted, @translator.add_rows_and_columns(TranslationLibrary.ruby_alpha_formatted)

    translation = TranslationLibrary.abcs_braille_formatted
    assert_equal translation, @translator.add_rows_and_columns(TranslationLibrary.abcs_alpha_formatted)
  end

  def test_it_can_translate_to_braille
    assert_equal TranslationLibrary.four_hello_worlds_braille_formatted, @translator.translate_to_braille(TranslationLibrary.four_hello_worlds_alpha_plain)

    assert_equal TranslationLibrary.abcs_braille_formatted, @translator.translate_to_braille(TranslationLibrary.abcs_alpha_formatted)
  end

  def test_it_can_translate_to_braille_and_write_to_output
    @translator.stubs(:read_input_file).returns(TranslationLibrary.ruby_alpha_formatted)
    @translator.translate_to_braille_and_write_to_output

    assert_equal TranslationLibrary.ruby_braille_formatted, @translator.read_output_file

    @translator.stubs(:read_input_file).returns(TranslationLibrary.four_hello_worlds_alpha_plain)
    @translator.translate_to_braille_and_write_to_output

    assert_equal TranslationLibrary.four_hello_worlds_braille_formatted, @translator.read_output_file
  end

  # ---- translate braille to alpha ----

  def test_it_can_translate_to_alpha
    assert_equal TranslationLibrary.ruby_alpha_formatted, @translator.translate_to_alpha(TranslationLibrary.ruby_braille_formatted)

    assert_equal TranslationLibrary.four_hello_worlds_alpha_plain, @translator.translate_to_alpha(TranslationLibrary.four_hello_worlds_braille_formatted)

    assert_equal TranslationLibrary.abcs_alpha_formatted, @translator.translate_to_alpha(TranslationLibrary.abcs_braille_formatted)
  end

  def test_it_can_line_wrap_alpha
    assert_equal TranslationLibrary.four_hello_worlds_alpha_formatted, @translator.translate_to_alpha_and_line_wrap(TranslationLibrary.four_hello_worlds_braille_formatted)

    assert_equal TranslationLibrary.abcs_alpha_formatted, @translator.translate_to_alpha_and_line_wrap(TranslationLibrary.abcs_braille_formatted)
  end

  def test_it_can_translate_to_alpha_and_write_to_output
    @translator.stubs(:read_input_file).returns(TranslationLibrary.ruby_braille_formatted)
    @translator.translate_to_alpha_and_write_to_output

    assert_equal TranslationLibrary.ruby_alpha_formatted, @translator.read_output_file
  end
end
