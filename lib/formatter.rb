require './lib/dictionary'
require './lib/cluster'
require './lib/identifiable'

class Formatter
  include Identifiable

  def initialize
    @dictionary = Dictionary.new
  end

  def individual_chars(content)
    content.gsub("\n", '').chars
  end

  def braille?(content)
    content.gsub("\n", '').chars.all? { |char| @dictionary.braille_characters.include?(char) }
  end

  # ---- split into clusters ----

  def max_chars_per_cluster(content)
    braille?(content) ? 243 : 40
  end

  def last_cluster(alpha)
    split_into_clusters(alpha).length
  end

  def split_into_clusters(content)
    cluster_range = (1..(content.length / max_chars_per_cluster(content).to_f).ceil).to_a

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

  # ---- individual braille strings by cluster ----

  def braille_arrays_by_cluster_by_subrow(braille)
    split_into_clusters(braille).reduce({}) do |result, cluster|
      index = 0
      all_strings = []

      (cluster.text.gsub("\n", '').length / 6).times do
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

  # ---- line-wrapping ----

  def line_wrap_alpha(alpha)
    alpha.scan(/.{1,40}/).join("\n")
  end
end
