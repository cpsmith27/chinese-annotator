require_relative "lib/dictionary.rb"
require_relative "lib/segmenter.rb"

class Annotator
  def initialize
    @dict = Dictionary.new
    @dict.readO('data/compiledDict.o')
    @dict.putStats

    @seg = Segmenter.new(@dict)
  end

  def annotate(text)
    @seg.segment(text, 7)
  end
end

a = Annotator.new

puts a.annotate('中华人民共和国国旗是五星红旗，长和高的比例是3：2。红色的旗面象征着革命，黃色的五角星象征着光明。旗上的五颗五角星及其相互关系象征着中国共产党领导下的全国人民大团结。最大的一颗五角星代表中国共产党，四颗小五角星代表当时中国四个主要社会阶级。四颗小无角星各有一尖正对着大星的中心点，这表示围绕着一个中心团结一致，在形式上也显得紧凑美观。')
