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
        isEntry = @dict.entries(slice) != nil

        #puts "line[#{pos}..#{wordEnd}]\t\t#{slice}\t\t#{isEntry}"

        if wordEnd == pos
          output.push slice
          break
        elsif isEntry
          breakDown = segmentMM(slice, slice.length - 1)
          output.push [slice, breakDown]
          break
        end

        wordEnd -= 1
      end

      pos = wordEnd + 1
    end

    puts output.inspect
    output
  end
end


#['zhe xie', 'defi', ['zhe', 'defi'], ['xie', 'defi']]
#['xue sheng hui', 'defi', ['xue sheng', 'defi', ['xue', 'defi'], ['sheng', 'defi']], ['hui', 'defi']]
