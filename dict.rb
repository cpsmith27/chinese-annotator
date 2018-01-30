require_relative 'hsk.rb'

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

        pinyin = line.match(/\[[a-zA-Z0-9[:punct:] ]*?\]/).to_s
        pinyin.gsub!(/^\[/, '')
        pinyin.gsub!(/\]$/, '')

        defi_raw = line.match(/\/.*\//).to_s
        defi = defi_raw[1..-2].split("/")
        defi.each do |d|
          d.gsub!(/\p{Han}/){|han| "<span class=\"han\">#{han}</span><i class=\"hide fa fa-square-o\" aria-hidden=\"true\"></i>"}
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

        length = tokens.delete_at(0)
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
end

dict = Dictionary.new
dict.readU8("data/cedict.u8")
dict.compile('data/compiledDict.o')
dict.readO('data/compiledDict.o')
