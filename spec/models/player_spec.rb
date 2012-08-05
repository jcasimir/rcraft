require 'spec_helper'

describe Player do
  let(:player) { Player.new }

  context ".new" do
    it "accepts a name" do
      player = Player.new(:name => "Sample")
      player.name.should == "Sample"
    end

    it "sets a default name" do
      player.name.length.should > 0
    end
  end

  context ".buildings" do
    it "starts empty" do
      player.buildings.should be_empty
    end
  end

  context "#add_entity" do
    class DummyVillager
      def villager?
        true
      end
    end

    it "adds a new entity" do
      villager = DummyVillager.new
      expect{ player.add_entity(villager) }.to change{ player.villagers.count }.by(1)
    end
  end
end