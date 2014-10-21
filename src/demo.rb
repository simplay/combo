require_relative 'graph.rb'
require_relative 'adj_matrix.rb'

class Demo

  attr_reader :filename, :task, :start

  DEFAULT_FILE = "graph2"

  def initialize(args)
    @filename = args[:filename] || DEFAULT_FILE
    @task = args[:task]
    @start = args[:start] || "1"
    run_task
  end

  private

  def build_graph
    Graph.new("data/"+"#{@filename}")
  end

  def run_task
    case @task
      when 1
        run_graph_traversal
      when 2
        run_shortest_path
      else
        puts "unknown demo task. task 1 has been loaded instead."
    end
  end

  def run_shortest_path
    g = build_graph
    vertex_indices = g.vertices.select &:idx
    pairs = vertex_indices.product(vertex_indices)
    am = AdjMatrix.new(g)
    distances = am.shortes_paths

    pairs.each do |pair|
      pair_dist = distances[pair.first.idx][pair.last.idx]
      pair_dist = pair_dist.eql?(AdjMatrix::ALMOST_INF) ? "inf" : pair_dist.to_s
      puts "distance from i=#{pair.first.to_s} to j=#{pair.last.to_s}: #{pair_dist}"
    end
  end

  def run_graph_traversal
    g = build_graph
    r = g.retrieve_vertex(@start) || g.vertices.first
    puts "starting position: #{r.to_s}"
    g.dfs_traversal_at(r)
    g.bfs_traversal_at(r)
  end

end