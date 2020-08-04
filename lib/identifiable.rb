module Identifiable 
  def individual_chars(content)
    content.gsub("\n", "").chars
  end

  def is_braille?(content)
    if individual_chars(content).all? {|char| @dictionary.braille_characters.include?(char)}
      true
    else individual_chars(content).all? {|char| @dictionary.char_map.keys.include?(char)}
      false
    end
  end
end