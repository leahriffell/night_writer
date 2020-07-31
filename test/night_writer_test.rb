require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/night_writer'

class NightWriterTest < MiniTest::Test 
  def setup 
    ARGV.replace ['message.txt', 'braille.txt']
    @night_writer = NightWriter.new
  end
  
  def test_it_exists
    assert_instance_of NightWriter, @night_writer
    assert_equal 'braille.txt', @night_writer.output_file
  end
  
  def test_it_can_print_message_to_terminal
    assert_equal "Created 'braille.txt' containing 256 characters", @night_writer.terminal_message
  end
end