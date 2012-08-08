class PriorityQueue
  def initialize
    @list = []
  end

  def add(priority, item)
    @list << [priority, @list.length, item]
    @list.sort!
    self
  end

  def <<(items)
    add(*items)
  end

  def next
    @list.shift[2]
  end

  def any?
    @list.any?
  end
end