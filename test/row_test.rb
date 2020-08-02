require './test/helper_test'
require './lib/row'

class RowTest < MiniTest::Test
  def setup 
    @row = Row.new("row row row your boat")
  end

  def test_it_exists 
    assert_instance_of Row, @row
  end

  def test_it_has_readable_attributes
    assert_equal "row row row your boat", @row.text
  end
end
