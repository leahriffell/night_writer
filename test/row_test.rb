require './test/helper_test'
require './lib/row'

class RowTest < MiniTest::Test
  def test_it_exists 
    @row = Row.new("row row row your boat")
    assert_instance_of Row, @row
  end
end
