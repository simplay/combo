class ContainerStructure

  attr_reader :container, :remover

  # dfs depth first search
  # bfs breath first search
  def initialize(is_dfs=true)
    @container = []
    @remover = (is_dfs) ? :pop
                        : :shift
  end

  # push item to the right
  def push(item)
    @container << item
  end

  def update_target_by(target, value)
    @container.each do |item|
      item.p = value if item.eql?(target)
    end
  end

  # @return [Vertex] current top or first element.
  def remove
    @container.send(@remover)
  end

  def empty?
    @container.empty?
  end

end