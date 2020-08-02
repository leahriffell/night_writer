require './test/helper_test'
require './lib/dictionary'

class DictionaryTest < MiniTest::Test 
  def setup 
    @dictionary = Dictionary.new
  end

  def test_it_exists 
    assert_instance_of Dictionary, @dictionary
  end
end