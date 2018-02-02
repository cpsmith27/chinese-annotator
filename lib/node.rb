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
end
