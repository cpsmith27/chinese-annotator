class Node
  def initialize(expression, dictEntries, children)
    @expression = expression
    @dictEntries = dictEntries
    @children = children
  end

  def getExpression
    @expression
  end

  def getEntries
    @dictEntries
  end

  def getChildren
    @children
  end

  def html
    if @children == nil
      "<span>#{@expression}</span>"
    else
      htmls = []
      @children.each do |c|
        htmls.push c.html
      end

      return "<span>#{htmls.join('')}</span>"
    end
  end
end
