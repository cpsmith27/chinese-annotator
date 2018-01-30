class HSK

  def initialize(hsk_files)
    puts "Loading hsk files: #{hsk_files.join(', ')}..."

    @hsk = {}
    (1..6).each do |level|
      @hsk[level] = []

      File.open(hsk_files[level-1]) do |f|
        while line = f.gets
          line.strip!
          next if line == ''

          @hsk[level] << line
        end
      end
    end
  end

  def getLevel(word)
    if @hsk[1].include?(word) or (word.length == 1 and @hsk[1].any?{|i| i.include?(word)})
      1
    elsif @hsk[2].include?(word) or (word.length == 1 and @hsk[2].any?{|i| i.include?(word)})
      2
    elsif @hsk[3].include?(word) or (word.length == 1 and @hsk[3].any?{|i| i.include?(word)})
      3
    elsif @hsk[4].include?(word) or (word.length == 1 and @hsk[4].any?{|i| i.include?(word)})
      4
    elsif @hsk[5].include?(word) or (word.length == 1 and @hsk[5].any?{|i| i.include?(word)})
      5
    elsif @hsk[6].include?(word) or (word.length == 1 and @hsk[6].any?{|i| i.include?(word)})
      6
    else
      "∞"
    end
  end
end
