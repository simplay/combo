class Edge

  attr_accessor :from, :to, :is_directional, :weight

  # @param from Vertex starting vertex
  # @param to Vertex ending vertex
  # @param is_directed Boolean is this edge directed?
  def initialize(from, to, is_directional=false, weight=1)
    @from = from
    @to = to
    @is_directional = is_directional
    @weight = weight
    @from.append_edge(self)
    @to.append_edge(self) unless is_directional
  end

  def u
    @from.idx-1
  end

  def v
    @to.idx-1
  end

  def to_s
    del = "->"
    del = "<" + del unless is_directional
    "#{from.to_s}#{del}#{to.to_s}"
  end
end