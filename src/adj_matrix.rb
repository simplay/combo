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

  def initialize(graph)
    vertices = graph.vertices
    v_count = vertices.count

    almost_inf = (1 << (1.size * 8 - 2) - 1)
    @schema = []
    # init adj. mat
    v_count.times do |idx|
      a_row = []
      v_count.times do |idx|
        a_row << almost_inf
      end
      schema << a_row
    end
    binding.pry
    #foreach edge label
    graph.edges.each do |edge|

      @schema[edge.u][edge.v] = edge.weight
    end


  end

  def shortes_path

  end


end