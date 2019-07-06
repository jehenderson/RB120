class CircularQueue
  @@i = 0
  
  attr_accessor :queue
  attr_reader :size
  
  def initialize(size)
    @queue = Array.new
    @size = size
  end
  
  def enqueue(obj)
    if queue.size < size
      queue.push(obj)
    else
      queue[@@i/size + @@i] = obj
      @@i += 1
    end
  end
  
  def dequeue
    queue.shift
  end
end

# Test Cases
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil