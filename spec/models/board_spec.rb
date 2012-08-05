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
end