module TranslationLibrary 
  def four_hello_worlds_alpha_plain
    "hello worldhello worldhello worldhello world"
  end

  def four_hello_worlds_alpha_formatted
    "hello worldhello worldhello worldhello w\norld"
  end

  def four_hello_worlds_braille_formatted
    "0.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....00.0.0.000.0.0.0.0....0\n00.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00.0000..000.00.0..0..00\n....0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....00.0.0.......0.0.0....0\n0.0.0.00\n.0000..0\n0.0.0..."
  end

  def abcs_alpha_formatted
    "abcdefghijklmnopqrstuvwxyz"
  end

  def abcs_braille_formatted
    "0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000.\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.0\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000"
  end

  def ruby_alpha_formatted
    "ruby"
  end

  def ruby_braille_formatted
    "0.0.0.00\n00..0..0\n0.00..00"
  end

  def ru_alpha_formatted
    "ru"
  end

  def ru_alpha_braille_formatted
    "0.0.\n00..\n0.00"
  end
end