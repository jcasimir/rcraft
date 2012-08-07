module Trainable
  attr_accessor :training_time_remaining

  def in_training?
    training_time_remaining > 0
  end

  def train!
    self.training_time_remaining = 0
    self
  end

  def trained?
    !in_training?
  end
end