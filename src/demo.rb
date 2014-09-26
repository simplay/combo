require_relative 'graph.rb'

class Demo

  attr_reader :filename, :task

  DEFAULT_FILE = "graph1"

  def initialize(args)
    @filename = args[:filename] || DEFAULT_FILE
    @task = args[:task]
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
    g.demo_graph_traversals
  end

end