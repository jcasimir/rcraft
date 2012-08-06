require 'spec_helper'

describe ResourceDeposit do
  let(:resource){ ResourceDeposit.new(5) }

  context ".new" do
    it "accepts a value" do
      resource.value == 5
    end
  end

  context "#resources?" do
    it "is" do
      resource.should be_resources
    end
  end

  context "#gather" do
    it "fetches a ResourcePack" do
      resource.gather(2).should be_a(ResourcePack)
    end

    it "fetches the right value of resources" do
      resource.gather(2).value.should == 2
    end

    it "decreases the value correctly" do
      expect{ resource.gather(2) }.to change{ resource.value}.by(-2)
    end

    context "runs out of resources" do
      it "only fetches remaining resources" do
        resource.gather(10).value.should == 5      
      end

      it "becomes makes the deposit empty" do
        resource.gather(10)
        resource.should be_empty
      end
    end
  end
end