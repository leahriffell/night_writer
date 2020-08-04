require './lib/dictionary'

class Formatter
  def initialize
    @dictionary = Dictionary.new
  end

  def is_braille?(content)
    if content.gsub("\n", "").chars.all? do |char| 
      @dictionary.braille_characters.include?(char)
    end
      true
    else content.gsub("\n", "").chars.all? {|char| @dictionary.char_map.keys.include?(char)}
      false
    end
  end
end