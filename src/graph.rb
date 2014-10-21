require_relative 'vertex.rb'
require_relative 'edge.rb'
require_relative 'my_stack.rb'
require_relative 'my_queue.rb'

require 'pry'

class Graph

  attr_reader :vertices, :edges, :is_directed

  def initialize(file_name)
    @vertices = Set.new
    @edges = Set.new
    load_file(file_name)
    to_s
  end

  def dfs_traversal_at(r)
    stack = MyStack.new
    stack.push(r)
    path = []
    while(!stack.empty?)
      vertex = stack.remove
      if vertex.p == -1
        vertex.p = 1337
        vertex.neighbor_vertices.each do |neighbor|
          stack.push(neighbor)
        end
        path << vertex
      end
    end
    traversal_method = "DFS"

    puts "traversed path (#{traversal_method})"
    path.each {|v| print(v.to_s + ' ')}
    puts "\n"
    unmark_vertices
  end

  def bfs_traversal_at(r)
    queue = MyQueue.new
    r.p = 1337
    queue.push(r)
    path = []
    while(!queue.empty?)
      vertex = queue.remove
      vertex.neighbor_vertices.each do |neighbor|
        if neighbor.p == -1
          neighbor.p = vertex.p
          queue.push(neighbor)
        end
      end
      path << vertex
    end
    traversal_method = "BFS"
    puts "traversed path (#{traversal_method})"
    path.each {|v| print(v.to_s + ' ')}
    puts "\n"
    unmark_vertices
  end

  def retrieve_vertex(label)
    @vertices.find { |el| el.id == label}
  end

  # print components of graph
  # i.e. its vertices and edges.
  def to_s
    puts "#{@vertices.count} vertices:"
    @vertices.each {|v| puts v.to_s}
    puts
    puts "#{@edges.count} edges:"
    @edges.each {|e| puts "#{e.to_s} w: #{e.weight}"}
    puts

  end

  private

  def unmark_vertices
    @vertices.each &:unmark
  end

  # load given file
  def load_file(file_name)
    state = nil
    file = File.new(file_name, "r")
    while (line = file.gets)
      state = state_of(line) if (line =~ /#/)
      process(line, state)
    end
    file.close
  end

  # @param line String line of file
  # @param state what type of line are we currently reading
  def process(line, state)
    line_content = line.split(/\s/)
    if line_content.length > 1
      case state
        when 'm'
          @is_directed = line_content.last.eql?('1')
        when 'v'
          build_vertex(line_content)
        when 'e'
          build_edge(line_content)
        else
          puts "undefined state"
      end
    end
  end

  # a vertex builder using data from current read line.
  # @param line [String] currently read line
  def build_vertex(line)
    vertex_keys = [:id, :p]
    vertex_arguments = {}
    line.each_with_index do |item, idx|
      vertex_arguments[vertex_keys[idx]] = item
    end
    @vertices.add(Vertex.new(vertex_arguments))
  end

  # a vertex builder using data from current read line.
  # @param line [String] currently read line
  def build_edge(line)
    vertices = [0,1].map do |idx|
      @vertices.select{|vertex| line[idx].eql?(vertex.id)}.first
    end

    vertices = sort_id_ascending_of(vertices) unless @is_directed

    if(line.count < 3)
      @edges.add(Edge.new(vertices.first, vertices.last, @is_directed))
    else
      weight = line[2].to_f
      @edges.add(Edge.new(vertices.first, vertices.last, @is_directed, weight))
    end





  end

  # get state from graph file
  # telling us what kind of line we are dealing with
  # in order to determine how we have to proceed this line.
  # Note that white-spaces are chomped
  # valid states:
  #   'm' meta information
  #   'v' vertex data
  #   'e' edge data
  # @param line [String] currently read line
  def state_of(line)
    (line.split(/#/).map &:chomp).last
  end

  # sort vertex ids ascending if we have an undirected graph
  def sort_id_ascending_of(vertices)
    first_v = vertices.first
    last_v = vertices.last
    if first_v.id.to_i > last_v.id.to_i
      vertices[1] = first_v
      vertices[0] = last_v
    end
    vertices
  end

end