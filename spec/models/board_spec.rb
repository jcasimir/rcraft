require 'spec_helper'

describe Board do
  let(:board) { Board.new }

  context ".new" do
    it "accepts a size" do
      expect{Board.new([200,200])}.to_not raise_error  
    end

    it "sets the size" do
      Board.new([200,200]).size.should == [200,200]
    end
  end

  context "#spawn_resources" do
    it "creates resources" do
      board.resource_value_at([0,0]).should == 0
      board.spawn_resource(ResourceDeposit.new(5), [0,0])
      board.resource_value_at([0,0]).should == 5
    end
  end

  class DummyBuilding
    def placed_on(board); end
  end

  context "with no buildings" do
    let(:building){ DummyBuilding.new }

    context "#place" do
      it "adds a building" do      
        board.place(building, [0,0])
        board.buildings.should include(building)
      end

      it "uses a location" do
        board.place(building, [2,2])
        board.entities_at([2,2]).should include(building)
      end
    end    
  end

  context "with buildings" do
    let(:building){
      DummyBuilding.new.tap do |b|
        board.place(b, [0,0])
      end
    }

    context "#tick" do
      it "tells buildings to tick" do
        building.should_receive :tick
        board.tick
      end
    end
  end
end