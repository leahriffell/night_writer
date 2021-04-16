module Identifiable
  def individual_chars(content)
    content.gsub("\n", '').chars
  end

  def braille?(content)
    individual_chars(content).all? { |char| @dictionary.braille_characters.include?(char) }
  end
end