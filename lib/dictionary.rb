class Dictionary
  attr_reader :char_map

  def initialize
    @char_map = {}
    map_character_to_braille
  end

  def map_character_to_braille
    @char_map[' '] = '......'
    @char_map['a'] = '0.....'
    @char_map['b'] = '0.0...'
    @char_map['c'] = '00....'
    @char_map['d'] = '00.0..'
    @char_map['e'] = '0..0..'
    @char_map['f'] = '000...'
    @char_map['g'] = '0000..'
    @char_map['h'] = '0.00..'
    @char_map['i'] = '.00...'
    @char_map['j'] = '.000..'
    @char_map['k'] = '0...0.'
    @char_map['l'] = '0.0.0.'
    @char_map['m'] = '00..0.'
    @char_map['n'] = '00.00.'
    @char_map['o'] = '0..00.'
    @char_map['p'] = '000.0.'
    @char_map['q'] = '00000.'
    @char_map['r'] = '0.000.'
    @char_map['s'] = '.00.0.'
    @char_map['t'] = '.0000.'
    @char_map['u'] = '0...00'
    @char_map['v'] = '0.0.00'
    @char_map['w'] = '.000.0'
    @char_map['x'] = '00..00'
    @char_map['y'] = '00.000'
    @char_map['z'] = '0..000'
  end

  def braille_characters
    ['0', '.']
  end
end
