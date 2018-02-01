def pinyinAccents(numbered)
  tokens = numbered.split(' ')

  accents = {
    'a': ['ā', 'á', 'ǎ', 'à', 'a'],
    'e': ['ē', 'é', 'ě', 'è', 'e'],
    'o': ['ō', 'ó', 'ǒ', 'ò', 'o'],
    'ui': ['uī', 'uí', 'uǐ', 'uì', 'ui'],
    'iu': ['iū', 'iú', 'iǔ', 'iù', 'iu'],
    'i': ['ī', 'í', 'ǐ', 'ì', 'i'],
    'u': ['ū', 'ú', 'ǔ', 'ù', 'u'],
    'v': ['ǖ', 'ǘ', 'ǚ', 'ǜ', 'ü']
  }

  output = []
  tokens.each do |t|
    if t.match(/^\[?[a-zA-Z]+[1-5]\]?$/)
      tone = t.match(/[1-5]/).to_s.to_i - 1
      t.gsub!(/[1-5]/, '')

      if t.match(/a/)
        t.gsub!(/a/, accents[:a][tone])
      elsif t.match(/e/)
        t.gsub!(/e/, accents[:e][tone])
      elsif t.match(/o/)
        t.gsub!(/o/, accents[:o][tone])
      elsif t.match(/ui/)
        t.gsub!(/ui/, accents[:ui][tone])
      elsif t.match(/iu/)
        t.gsub!(/iu/, accents[:iu][tone])
      elsif t.match(/u/)
        t.gsub!(/u/, accents[:u][tone])
      elsif t.match(/i/)
        t.gsub!(/i/, accents[:i][tone])
      elsif t.match(/u\:/)
        t.gsub!(/u\:/, accents[:v][tone])
      end
    end

    output.push t
  end

  return output.join(' ')
end
