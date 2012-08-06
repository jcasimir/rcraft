require 'spec_helper'

describe ResourcePack do
  context ".new" do
    it "accepts a value" do
      ResourcePack.new(100).value.should == 100
    end
  end
  
end