require_relative "lib/dictionary.rb"

dict = Dictionary.new
dict.readU8("data/cedict.u8")
dict.compile('data/compiledDict.o')
dict.readO('data/compiledDict.o')
