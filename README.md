# [Night Writer](https://backend.turing.io/module1/projects/night_writer/) 
### Turing Mod 1 Independent Project
Program for translating alphabetical characters into Braille and vice versa. 

# Instructions 
- Latin alphabet to Braille:
  - Input your desired message for translation into message.txt 
  - `$ ruby ./lib/night_writer.rb message.txt braille.txt`
- Braille to Latin alphabet: 
  - Input your desired message for translation into braille.txt 
  - `$ ruby ./lib/night_reader.rb braille.txt original_message.txt`

# Class Descriptions 
- **Translator**: handles translating and formatting of Braille to Latin alphabet and vice versa 
  - Translator requires all classes below
- **Dictionary**: provides mapping of each alphabet character to its Braille equivalent
- **FileManager**: manages file functions (input, output, creation, reading)
- **Cluster**: each cluster represents 1 line of content for text-wrapping purposes (40 alphabetic characters / 80 braille characters)
  - If Braille, there are 3 rows of 80 characters (240 characters total)
  - If alphabetical characters, there is 1 row of 40 characters


