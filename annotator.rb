require_relative "lib/dictionary.rb"
require_relative "lib/segmenter.rb"

dict = Dictionary.new
#dict.readU8("data/cedict.u8")
#dict.compile('data/compiledDict.o')
dict.readO('data/compiledDict.o')
puts dict.stats

seg = Segmenter.new(dict)
seg.segmentMM('这些学生会游泳', 5)
