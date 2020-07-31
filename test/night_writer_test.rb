require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_writer'

class NightWriterTest < MiniTest::Test 
  def setup 
    @night_writer = NightWriter.new
  end

  def test_it_exists 
    assert_instance_of NightWriter, @night_writer
  end
end