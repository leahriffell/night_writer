require './test/helper_test'
require './lib/cluster'

class ClusterTest < MiniTest::Test
  def setup 
    @cluster = Cluster.new("A braille cluster = parent w/ 3 subrows")
  end

  def test_it_exists 
    assert_instance_of Cluster, @cluster
  end

  def test_it_has_readable_attributes
    assert_equal "A braille cluster = parent w/ 3 subrows", @cluster.text
  end
end
