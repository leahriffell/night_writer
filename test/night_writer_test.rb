require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/night_writer'
# require './message'

class NightWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    # message.txt
    @night_writer = NightWriter.new
  end
  
  def test_it_exists
    assert_instance_of NightWriter, @night_writer
    assert_equal 'braille.txt', @night_writer.output_file
  end
  
  def test_it_can_return_terminal_message
    assert_equal "Created 'braille.txt' containing 256 characters", @night_writer.terminal_message
  end

  def test_it_can_read_input_file
    assert_equal "This has characters!", @night_writer.read_input_file
    assert_equal 20, @night_writer.read_input_file.length
  end
end