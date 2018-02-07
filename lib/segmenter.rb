require_relative 'node.rb'

class Segmenter
  def initialize(dictionary)
    @dict = dictionary
  end

  def segmentMM(line, maxWordLength)
    lim = line.length - 1

    output = []

    pos = 0
    while pos <= lim
      wordEnd = pos + maxWordLength - 1
      if wordEnd > lim
        wordEnd = lim
      end

      while wordEnd >= pos
        slice = line[pos..wordEnd]
        entries = @dict.entries(slice)

        if wordEnd == pos
          output.push Node.new(slice, entries, nil)
          break
        elsif entries != nil
          breakDown = segmentMM(slice, slice.length - 1)
          output.push Node.new(slice, entries, breakDown)
          break
        end

        wordEnd -= 1
      end

      pos = wordEnd + 1
    end

    output
  end
end
