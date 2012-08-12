require 'spec_helper'

describe Camp do
  class DummyPlayer
    def add_entity(entity); end
  end

  let(:player){ DummyPlayer.new }
  let(:camp){ Camp.new(player) }

  context ".new" do
    it "takes a player" do
      Camp.new("player 1").player.should == "player 1"
    end
  end

  context "#dimensions" do
    it "is 2x2" do
      camp.dimensions.should == [2,2]
    end
  end

  context "#create_villager" do
    context "when a slot is available" do
      it "begins creating a villager" do
        camp.training_slots = 1
        villager = camp.create_villager
        camp.in_progress.should include(villager)
      end
    end

    context "when slots are filled" do
      it "adds them to the queue" do
        camp.training_slots = 0
        villager = camp.create_villager
        camp.in_progress.should_not include(villager)
        camp.training_queue.should include(villager)
      end
    end
  end

  context "#training_time_for" do
    it "returns a number of cycles" do
      camp.set_training_time_for(:villager, 5)
      camp.training_time_for(:villager).should == 5
    end
  end

  context "#cost_to_train" do
    it "returns a currency quantity" do
      camp.set_cost_to_train(:villager, 400)
      camp.cost_to_train(:villager).should == 400
      camp.set_cost_to_train(:villager, 100)
      camp.cost_to_train(:villager).should == 100
    end
  end

  context "#tick" do
    it "advances any pending builds" do
      villager = camp.create_villager
      expect{ camp.tick }.to change{ villager.training_time_remaining }
    end

    class CompletedTraining
      def trained?; true; end
      def tick; end
    end

    let(:completed_training){ CompletedTraining.new }

    it "spawns completed trainings" do
      camp.in_progress << completed_training
      camp.in_progress.should include(completed_training)
      camp.tick
      camp.in_progress.should_not include(completed_training)
    end
  end

  context "#spawn_entity" do
    let(:player){ double(:player) }
    let(:camp_with_player){ Camp.new(player) }
    let!(:villager){ camp_with_player.create_villager }

    it "removes the entity from the build queue" do
      camp_with_player.in_progress.should include(villager)
      player.should_receive(:add_entity).with(villager)
      camp_with_player.spawn_entity(villager)
      camp_with_player.in_progress.should_not include(villager)
    end

    it "puts the entity on the board"
  end
end