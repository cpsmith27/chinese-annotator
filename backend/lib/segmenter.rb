require 'json'

class Segmenter
  def initialize(dictionary)
    @dict = dictionary
  end

  # Give all the possible combinations to divide characters in a string.
  def compute_combinations(string)
    if string == "" or string == nil
      return []
    elsif string.length == 1
      return [string]
    else
      combinations = [[string]]

      lim = string.length - 1
      pos = lim

      while pos > 0
        right = string[0..pos-1]
        lefts = compute_combinations(string[pos..lim])

        lefts.each do |l|
          combinations << [right, l].flatten
        end

        pos -= 1
      end

      return combinations
    end
  end

  def valid_combination?(combination)
    return !combination.any?{ |c| @dict.entries(c) == nil }
  end

  # Simple maximum match segmentation with all possible "sub"-segmentations
  def segment(line, maxWordLength)
    lim = line.length - 1

    # The line will be segmented into segment_groups, which contain the different ways to break down
    # a certain group of characters based on dictionary entries.
    segment_groups = []

    # Main loop iterating through the whole line.
    pos = 0
    while pos <= lim
      # Start with largest grouping possible (<= maxWordLength)
      wordEnd = pos + maxWordLength - 1
      if wordEnd > lim
        wordEnd = lim
      end

      while wordEnd >= pos
        slice = line[pos..wordEnd]
        in_dictionary = @dict.entries(slice) != nil

        if wordEnd == pos
          segment_groups << { in_dictionary: in_dictionary, segmentations: [[slice]] }
          break
        elsif in_dictionary
          valid_combinations = []
          combinations = compute_combinations(slice)
          combinations.each do |c|
            if valid_combination?(c)
              valid_combinations << c
            end
          end
          segment_groups << { in_dictionary: in_dictionary, segmentations: valid_combinations }
          break
        end

        wordEnd -= 1
      end

      pos = wordEnd + 1
    end

    return JSON.generate(text_blocks: [{segmentation_groups: segment_groups}])
  end
end
