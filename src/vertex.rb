class Vertex
  
  attr_accessor :id, :p, :meeting_edges, :idx

  def initialize(args)
    @meeting_edges = []
    args.each do |key, value|
      send("#{key}=", value) 
    end
    postprocess_arguments
  end

  # @param [String] self.id of this vertex.
  def to_s
    "#{id}"
  end

  # append an edge which meets at this vertex.
  # @param edge [Edge] meeting edge
  def append_edge(edge)
    @meeting_edges << edge
  end

  # collect all 1-neighborhood vertices of this vertex.
  # @return [Array] collection of 1-neighborhood vertices.
  def neighbor_vertices
    @meeting_edges.map &:to
  end

  def unmark
    @p = -1
  end

  private

  def postprocess_arguments
    @p = @p.to_i
    @idx = id.to_i
  end
  
end