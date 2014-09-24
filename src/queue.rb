class Queue

  attr_reader :container

  def initialize
    @container = []
  end

  # push item to the right
  def push(item)
    @container << item
  end

  def pop
    @container.pop
  end

  def empty?
    @container.empty?
  end

end