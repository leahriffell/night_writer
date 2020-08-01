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

  def test_it_can_return_with_braille_formatting
    assert_equal "00\n.0\n0.", @translator.convert_to_braille("n")
    assert_equal "00\n.0\n00", @translator.convert_to_braille("ys")
  end
end