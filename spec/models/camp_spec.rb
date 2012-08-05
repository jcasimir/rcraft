require 'spec_helper'

describe Camp do
  let(:camp){ Camp.new }

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
    it "begins creating a villager" do
      camp.create_villager.should be_kind_of(Villager)
    end

    it "puts that villager into the build process" do
      camp.create_villager
      camp.in_progress.any?{|e| e.respond_to?(:villager?) && e.villager?}.should be
    end
  end

  context "#training_time_for" do
    it "returns a number of cycles" do
      camp.set_training_time_for(:villager, 5)
      camp.training_time_for(:villager).should == 5
    end
  end

  context "#tick" do
    it "advances any pending builds" do
      villager = camp.create_villager
      expect{ camp.tick }.to change{ villager.training_time_remaining }
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
  end
end