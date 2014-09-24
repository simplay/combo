class Edge

  attr_accessor :from, :to, :is_directional

  # @param from Vertex starting vertex
  # @param to Vertex ending vertex
  # @param is_directed Boolean is this edge directed?
  def initialize(from, to, is_directional=false)
    @from = from
    @to = to
    @is_directional = is_directional

    @from.append_edge(self)
    @to.append_edge(self) unless is_directional
  end

  def to_s
    del = "->"
    del = "<" + del unless is_directional
    "#{from.to_s}#{del}#{to.to_s}"
  end
end