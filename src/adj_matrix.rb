# a = [[1,2], [3,4]]
#=> [[1, 2], [3, 4]]
# # a[1]
# => [3, 4]
#a[0]
# => [1, 2]
#a[0][0]
# => 1

class AdjMatrix

  attr_accessor :schema
  
  ALMOST_INF = (1 << (1.size * 8 - 2) - 1)

  def initialize(graph)
    @vertices = graph.vertices
    @v_count = @vertices.count

    @schema = []
    @next = []

    # init adj. mat
    @v_count.times do
      a_row = []
      a_next_row = []
      @v_count.times do
        a_row << ALMOST_INF
        a_next_row << nil
      end
      @schema << a_row
      @next << a_next_row
    end

    #foreach edge label
    graph.edges.each do |edge|
      @schema[edge.u][edge.v] = edge.weight
      @next[edge.u][edge.v] = edge.to
    end

    graph.vertices.each do |vertex|
      v_idx = vertex.idx
      @schema[v_idx][v_idx] = 0.0
    end

  end

  # Floyd–Warshall algorithm
  def shortes_paths
    distances = copied_schema

    @v_count.times do |k|
      @v_count.times do |i|
        @v_count.times do |j|
          relax(distances, i, j, k)
        end
      end
    end
    distances
  end

  # get path from a given vertex to a given vertex
  # convention: report 'path does not exist'
  # in case we query for path from Vertex v to Vertex v.
  # @param from Vertex start
  # @param to Vertex destination
  def shortest_path(from, to)
    u = from; v = to
    return "does not exist" if @next[u.idx][v.idx].nil?

    path = ("["+u.to_s + ",")

    until(u.eql?(v))
      u = @next[u.idx][v.idx]
      path += (u.to_s + ",")
    end
    path = path[0..path.size-2]
    path += "]"
    path
  end

  def to_s
    @schema.each do |row|
      row.each do |element|
        value = element.eql?(ALMOST_INF) ? "inf" : element.to_s
        print value + " "
      end
      puts
    end
  end

  private

  # update (i,j)-th element of given container
  # if it can be relaxed
  def relax(container, i, j, k)
    if(container[i][j] > container[i][k] + container[k][j])
      container[i][j] = container[i][k] + container[k][j]
      @next[i][j] = @next[i][k]
    end
  end

  # copy each value in the :schema into
  # a new instantiated 2d array.
  def copied_schema
    c = []
    @v_count.times do |i|
      c_row = []
      @v_count.times do |j|
        c_row << @schema[i][j]
      end
      c << c_row
    end
    c
  end

end