class Villager
  attr_accessor :home, :player, :training_time_remaining

  def initialize(home)
    @home = home
    @player = home.player
    @training_time_remaining = home.training_time_for(:villager)
  end

  def villager?
    true
  end

  def tick
    self.training_time_remaining -= 1 if in_training?
  end

  def in_training?
    training_time_remaining > 0
  end

  def done_training?
    !in_training?
  end
end