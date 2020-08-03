require './lib/translator'

translate_to_braille = Translator.new  
translate_to_braille.translate_to_braille_and_write_to_output
p translate_to_braille.terminal_message
