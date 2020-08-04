require './test/helper_test'
require './lib/formatter'

class FormatterTest < MiniTest::Test
  def setup 
    @formatter = Formatter.new
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

  def test_it_can_distinguish_alpha_from_braille
    assert_equal false, @formatter.is_braille?(@ruby_alpha_formatted)
    assert_equal true, @formatter.is_braille?(@ruby_braille_formatted)
  end

  def test_it_can_determine_max_chars_per_cluser
    assert_equal 40, @formatter.max_chars_per_cluster(@ruby_alpha_formatted)
    assert_equal 243, @formatter.max_chars_per_cluster(@ruby_braille_formatted)
  end

  def test_it_can_return_last_cluster_number 
    assert_equal 2, @formatter.last_cluster(@four_hello_worlds_alpha_plain)
  end

  def test_it_can_split_into_clusters
    assert_equal 2, @formatter.split_into_clusters(@four_hello_worlds_alpha_plain).count
    assert_equal 2, @formatter.split_into_clusters(@four_hello_worlds_braille_formatted).count
  end

  def test_it_can_return_collection_of_braille_arrays_by_row
    assert_equal ({@ru_alpha_braille_formatted => [["0.000."], ["0...00"]]}), @formatter.collection_of_braille_arrays_by_row(@ru_alpha_braille_formatted)

    # braille_arrays_by_row = {
    #   "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0" => [["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"], ["0..00."], ["0.000."], ["0.0.0."], ["00.0.."], ["0.00.."], ["0..0.."], ["0.0.0."], ["0.0.0."], ["0..00."], ["......"], [".000.0"]], "0.0.0.00\n.0000..0\n0.0.0..." => [["0..00."], ["0.000."], ["0.0.0."], ["00.0.."]]
    # }
    # assert_equal braille_arrays_by_row, @formatter.collection_of_braille_arrays_by_row(@four_hello_worlds_braille_formatted)
  end

  def test_it_can_line_wrap_alpha
    assert_equal @four_hello_worlds_alpha_formatted, @formatter.translate_to_alpha_and_line_wrap(@four_hello_worlds_alpha_plain)

    assert_equal @abcs_alpha_formatted, @formatter.translate_to_alpha_and_line_wrap(@abcs_alpha_formatted)
  end
end