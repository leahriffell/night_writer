require './lib/dictionary'
require './lib/cluster'

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

  def max_chars_per_cluster(content)
    if is_braille?(content)
      max_chars_per_cluster = 243
    else 
      max_chars_per_cluster = 40 
    end
    max_chars_per_cluster
  end 

  def last_cluster(alpha)
    split_into_clusters(alpha).length
  end

  def split_into_clusters(content)
    cluster_range = (1..(content.length/max_chars_per_cluster(content).to_f).ceil).to_a

    index = 0
    cluster_range.reduce([]) do |result, cluster|
      if cluster == cluster_range.last
        result << Cluster.new(content[index..-1])
      else 
        result << Cluster.new(content[index..(index + max_chars_per_cluster(content) - 1)])
      end
      index += max_chars_per_cluster(content)
      result
    end
  end

  def collection_of_braille_arrays_by_row(braille) 
    split_into_clusters(braille).reduce({}) do |result, cluster|
        index = 0 
        all_strings = []
        
        (cluster.text.gsub("\n", "").length/6).times do 
          braille_char = []
          braille_char << cluster.text.split("\n").map do |sub_row| 
            sub_row[index..(index + 1)]
          end.join
          all_strings << braille_char
          index += 2
        end 
        
      result[cluster.text] = all_strings
      result
    end
  end

  def translate_to_alpha_and_line_wrap(translated_braille)
    translated_braille.scan(/.{1,40}/).join("\n")
  end
end