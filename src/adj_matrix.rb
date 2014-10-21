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
    vertices = graph.vertices
    @v_count = vertices.count

    @schema = []
    # init adj. mat
    @v_count.times do
      a_row = []
      @v_count.times do
        a_row << ALMOST_INF
      end
      schema << a_row
    end

    #foreach edge label
    graph.edges.each do |edge|
      @schema[edge.u][edge.v] = edge.weight
    end

    graph.vertices.each do |vertex|
      v_idx = vertex.idx
      @schema[v_idx][v_idx] = 0.0
    end

  end

  # Floyd–Warshall algorithm
  def shortes_paths
    distances = @schema
    @v_count.times do |k|
      @v_count.times do |i|
        @v_count.times do |j|
          relax(distances, i, j, k)
        end
      end
    end
    distances
  end

  def relax(container, i, j, k)
    if(container[i][j] > container[i][k] + container[k][j])
      container[i][j] = container[i][k] + container[k][j]
    end
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


end