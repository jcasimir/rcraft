require 'spec_helper'

describe Villager do
  class Home
    def training_time_for(entity)
      10
    end

    def player
      "player 1"
    end
  end

  let(:home){ Home.new }

  let(:villager){ Villager.new(home) }

  it "has a home" do
    villager.home.should == home
  end

  it "belongs to a player" do
    villager.player.should == home.player
  end

  context "#villager?" do
    it "is" do
      villager.should be_villager
    end
  end

  context "#training_time_remaining" do
    it "goes from the build time to zero" do
      villager.training_time_remaining.should == home.training_time_for(:villager)
      home.training_time_for(:villager).times{ villager.tick }
      villager.training_time_remaining.should == 0
    end
  end

  context "#placed_on" do
    it "sets the board" do
      board = Board.new
      villager.placed_on(board)
      villager.board.should == board
    end
  end

  context "#resources_value" do
    it "is the total of carried resources" do
      villager.resources_value.should == 0
      villager.resources << ResourcePack.new(5)
      villager.resources_value.should == 5
    end
  end

  context "#train!" do
    it "marks the villager as trained" do
      villager.train!.should be_trained
    end
  end

  context "#gather_resources" do
    class DummyResourceDeposit
      def gather(x)
        {:value => x}
      end
    end

    class DummyBoard
      def resource_at(coordinates)
        DummyResourceDeposit.new
      end
    end

    before(:each) do
      spawned_villager.placed_on(DummyBoard.new)
      spawned_villager.time_to_gather_resources = 5
      spawned_villager.gather_resources([1,1])
    end

    let(:spawned_villager) do
      Villager.new(home).train!
    end

    it "does not initially gather anything" do
      spawned_villager.resources.count.should == 0
    end

    it "does not gather anything mid-timer" do
      spawned_villager.tick
      spawned_villager.resources.count.should == 0
    end

    it "gathers exactly on the cycle" do
      5.times{ spawned_villager.tick }
      spawned_villager.resources.count.should == 1
    end

    it "gathers only every X cycles" do
      11.times{ spawned_villager.tick }
      spawned_villager.resources.count.should == 2
    end
  end
end

  # context "movements" do
  #   class DummyBoard
  #     def move(entity, direction);end

  #     def path_for(entity, coordinates)
  #       [[1,0], [1,0], [1,0]]
  #     end

  #     def coordinates_for(e)
  #       [0,0]
  #     end

  #     def valid_coordinates?(coords); true; end
  #   end

  #   let(:board){ DummyBoard.new }

  #   before(:each) do
  #     villager.train!
  #     villager.placed_on(board)
  #   end

  #   context "#move_to" do
  #     it "starts moving" do
  #       villager.move_to([3,0])
  #       villager.should be_moving
  #     end

  #     it "moves" do
  #       villager.move_to([3,0])
  #       board.should_receive(:move)
  #       villager.time_to_move.times{ villager.tick }
  #     end

  #     it "finishes moving" do
  #       villager.move_to([3,0])
  #       board.should_receive(:move).exactly(3).times
  #       (3 * villager.time_to_move).times{ villager.tick }
  #       villager.should_not be_moving
  #     end
  #   end

  #   context "#next_move" do
  #     it "responds with the vector direction of the next movement" do
  #       villager.move_to([3,0])
  #       villager.next_move.should == [1,0]
  #     end
  #   end
  # end