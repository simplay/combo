require_relative 'graph.rb'

class Demo

  attr_reader :filename, :task, :start

  DEFAULT_FILE = "graph1"

  def initialize(args)
    @filename = args[:filename] || DEFAULT_FILE
    @task = args[:task]
    @start = args[:start] || "1"
    run_task
  end

  private

  def run_task
    case @task
      when 1
        run_graph_traversal
      else
        puts "unknown demo task. task 1 has been loaded instead."
    end
  end

  def run_graph_traversal
    g = Graph.new("data/"+"#{@filename}")
    r = g.retrieve_vertex(@start) || g.vertices.first
    puts "starting position: #{r.to_s}"
    g.dfs_traversal_at(r)
    g.bfs_traversal_at(r)
  end

end