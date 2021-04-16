require './test/helper_test'
require './lib/formatter'
require './test/fixtures/translation_library'

class FormatterTest < MiniTest::Test
  def setup
    @formatter = Formatter.new
  end

  def test_it_can_return_individual_chars
    assert_equal ['r', 'u', 'b', 'y'], @formatter.individual_chars(TranslationLibrary.ruby_alpha_formatted)
  end

  def test_it_can_distinguish_alpha_from_braille
    assert_equal false, @formatter.braille?(TranslationLibrary.ruby_alpha_formatted)
    assert_equal true, @formatter.braille?(TranslationLibrary.ruby_braille_formatted)
  end

  # ---- split into clusters ----

  def test_it_can_determine_max_chars_per_cluser
    assert_equal 40, @formatter.max_chars_per_cluster(TranslationLibrary.ruby_alpha_formatted)
    assert_equal 243, @formatter.max_chars_per_cluster(TranslationLibrary.ruby_braille_formatted)
  end

  def test_it_can_return_last_cluster_number 
    assert_equal 2, @formatter.last_cluster(TranslationLibrary.four_hello_worlds_alpha_plain)
  end

  def test_it_can_split_into_clusters
    assert_equal 2, @formatter.split_into_clusters(TranslationLibrary.four_hello_worlds_alpha_plain).count
    assert_equal 2, @formatter.split_into_clusters(TranslationLibrary.four_hello_worlds_braille_formatted).count
  end

  # ---- individual braille strings by cluster ----

  def test_it_can_return_braille_arrays_by_cluster_by_subrow
    assert_equal ({TranslationLibrary.ru_alpha_braille_formatted => [["0.000."], ["0...00"]]}), @formatter.braille_arrays_by_cluster_by_subrow(TranslationLibrary.ru_alpha_braille_formatted)
  end

  # ---- line-wrapping ----

  def test_it_can_line_wrap_alpha
    assert_equal TranslationLibrary.four_hello_worlds_alpha_formatted, @formatter.line_wrap_alpha(TranslationLibrary.four_hello_worlds_alpha_plain)

    assert_equal TranslationLibrary.abcs_alpha_formatted, @formatter.line_wrap_alpha(TranslationLibrary.abcs_alpha_formatted)
  end
end
