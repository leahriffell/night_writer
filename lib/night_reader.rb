require './lib/translator'

translate_to_alphabet = Translator.new  
translate_to_alphabet.translate_to_alpha_and_write_to_output
p translate_to_alphabet.terminal_message
