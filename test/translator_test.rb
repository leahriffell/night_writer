require './test/helper_test'
require './lib/translator'

class TranslatorTest < MiniTest::Test 
  def setup 
    @translator = Translator.new
  end

  def test_it_exists
    assert_instance_of Translator, @translator
  end

  def test_it_can_lookup_braille_for_character
    assert_equal "0......", @translator.char_to_braille("a")
    assert_equal "0.00..", @translator.char_to_braille("h")
  end

  def test_it_can_return_collection_of_braille_arrays
    assert_equal [["0.000."], ["0...00"]], @translator.collection_of_braille_translations("ru")
  end

  def test_it_can_split_into_rows
    assert_equal 2, @translator.split_into_rows("hello worldhello worldhello worldhello world").count
  end

  def test_it_can_translate_multi_chars_with_braille_formatting
    assert_equal "0.0.0.00\n00..0..0\n0.00..00", @translator.render_rows_and_columns("ruby")

    translation = "0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000.\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.0\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000"
    assert_equal translation, @translator.render_rows_and_columns("abcdefghijklmnopqrstuvwxyz")
  end


  def test_it_can_translate_and_output_to_braille
    assert_equal "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0...", @translator.translate_to_braille("hello worldhello worldhello worldhello world")
  end
end