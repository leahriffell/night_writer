require './test/helper_test'
require './lib/dictionary'

class DictionaryTest < MiniTest::Test 
  def setup 
    @dictionary = Dictionary.new
  end

  def test_it_exists 
    assert_instance_of Dictionary, @dictionary
  end

  def test_it_can_lookup_braille_for_character
    assert_equal "0.....", @dictionary.char_map["a"]
    assert_equal "0.00..", @dictionary.char_map["h"]
    assert_equal "......", @dictionary.char_map[" "]
  end

  def test_it_can_return_chars_used_within_braille
    assert_equal ["0", "."], @dictionary.braille_characters
  end
end