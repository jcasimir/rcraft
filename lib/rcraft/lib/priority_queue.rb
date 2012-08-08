class PriorityQueue
  attr_accessor :queue

  def initialize
    @queue = []
  end

  def add(priority, item)
    self.queue << [priority, queue.length, item]
    queue.sort!
    self
  end

  def <<(items)
    add(*items)
  end

  def next
    queue.shift[2]
  end

  def any?
    queue.any?
  end
end