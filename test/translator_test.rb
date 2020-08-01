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
    assert_equal "0......", @translator.char_map[:a]
    assert_equal "0.00..", @translator.char_map[:h]
  end

  def test_it_can_convert_to_multi_line
    assert_equal "0.\n0.\n00", @translator.convert_to_multi_line("0.0.00")
  end

  def test_it_can_translate_with_braille_formatting
    assert_equal "00\n.0\n0.", @translator.char_to_braille_with_formatting("n")
    assert_equal "00\n.0\n00", @translator.char_to_braille_with_formatting("y")
  end
end