require_relative './hsk.rb'
require_relative './pinyinAccents.rb'

class Dictionary

  def readU8(file)
    hsk = HSK.new(["data/hsk1.txt", "data/hsk2.txt", "data/hsk3.txt", "data/hsk4.txt", "data/hsk5.txt", "data/hsk6.txt"])

    puts "Processing dictionary file: #{file}..."

    entries = 0

    @dict = {}
    File.open(file, "r") do |d|
      while line = d.gets

        line.strip!
        next if line == '' or line.start_with?("#")

        entries += 1
        print "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b#{entries} entries..."

        tokens = line.split(' ')
        trad = tokens.first
        simp = tokens[1]

        pinyin_raw = line.match(/\[[a-zA-Z0-9[:punct:] ]*?\]/).to_s
        pinyin_raw.gsub!(/^\[/, '')
        pinyin_raw.gsub!(/\]$/, '')
        pinyin = pinyinAccents(pinyin_raw)

        defi_raw = line.match(/\/.*\//).to_s
        defi = defi_raw[1..-2].split("/")
        defi.each do |d|
          d.gsub!(/\p{Han}/) {|han| "<span class=\"han\">#{han}</span>"}
          d.gsub!(/\[[a-zA-Z]+[1-5]\]/) {|pin| pinyinAccents(pin)}
        end

        hsk_level = hsk.getLevel(simp)

        if @dict[simp.length].nil?
          @dict[simp.length] = {}
        end

        if @dict[simp.length][simp].nil?
          @dict[simp.length][simp] = [{
            trad: trad,
            pinyin: pinyin,
            defi: defi,
            hsk: hsk_level
          }]
        else
          @dict[simp.length][simp] << {
            trad: trad,
            pinyin: pinyin,
            defi: defi,
            hsk: hsk_level
          }
        end
      end

    end

    puts ''
  end

  def compile(file)

    puts "Compiling to file: #{file}..."
    entries = 0

    File.open(file, "w") do |cd| #compiled dict

      @dict.each do |length, lEntries|
        lEntries.each do |simp, sEntries|
          sEntries.each do |e|
            cd.puts "#{length}\t#{simp}\t#{e[:trad]}\t#{e[:pinyin]}\t#{e[:hsk]}\t#{e[:defi].join("\t")}"

            entries += 1
            print "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b#{entries} entries..."
          end
        end
      end

    end

    puts ''
  end

  def readO(file)
    puts "Processing dictionary file: #{file}..."

    entries = 0

    @dict = {}
    File.open(file, "r") do |d|
      while line = d.gets

        line.strip!
        next if line == '' or line.start_with?("#")

        tokens = line.split("\t")

        length = tokens.delete_at(0).to_i # make sure this is a number
        simp = tokens.delete_at(0)
        trad = tokens.delete_at(0)
        pinyin = tokens.delete_at(0)
        hsk = tokens.delete_at(0)

        if @dict[length].nil?
          @dict[length] = {}
        end

        if @dict[length][simp].nil?
          @dict[length][simp] = [{
            trad: trad,
            pinyin: pinyin,
            hsk: hsk,
            defi: tokens
          }]
        else
          @dict[length][simp] << {
            trad: trad,
            pinyin: pinyin,
            hsk: hsk,
            defi: tokens
          }
        end

        entries += 1
        print "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b#{entries} entries..."
      end
    end

    puts ''
  end

  def entries(word)
    @dict[word.length][word] rescue nil
  end

  def maxLength()
    @dict.keys.max
  end

  def numberOfHeadWords()
    total = 0
    @dict.each do |length, headWordEntries|
      total += headWordEntries.size
    end

    total
  end

  def stats()
    puts '================================='
    puts 'Stats:'
    puts ''

    l = @dict.keys.max - 1
    totalSize = self.numberOfHeadWords

    puts "Number of Head Words: #{totalSize}"

    previousPercentage = 0
    (1..l).each do |length|
      size = @dict[length].size
      slicePercentage = size.to_f / totalSize * 100
      accuPercentage = previousPercentage + slicePercentage

      puts "Words of length #{length}: #{size} (slice: #{slicePercentage.round(2)}%, accumulated: #{accuPercentage.round(2)}%)"

      previousPercentage = accuPercentage
    end
  end
end
