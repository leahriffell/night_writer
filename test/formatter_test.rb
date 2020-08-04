require './test/helper_test'
require './lib/formatter'

class FormatterTest < MiniTest::Test
  def setup 
    @formatter = Formatter.new
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

  def test_it_can_distinguish_alpha_from_braille
    assert_equal false, @formatter.is_braille?("ruby")
    assert_equal true, @formatter.is_braille?("0.0.0.00\n00..0..0\n0.00..00")
  end
end