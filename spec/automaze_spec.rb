# coding: utf-8

require_relative "../automaze"

describe Automaze::Automaze do
  describe "self.include_algorithm" do
    it "includes algorithm module" do
      lambda { Automaze::Automaze.include_algorithm(:boutaoshi) }.should_not raise_error
    end
  end

  describe "new" do
    it "returns Automaze class" do
      Automaze::Automaze.new.class.should == Automaze::Automaze
    end

    describe "using options" do
      describe ":algorithm" do
        it "accepts :boutaoshi" do
          lambda { Automaze::Automaze.new(:algorithm=>:boutaoshi) }.should_not raise_error
        end
        it "doesnt accept :invalid_algorithm" do
          lambda { Automaze::Automaze.new(:algorithm=>:invalid_algorithm) }.should raise_error
        end
      end
    end
  end

  describe "instance" do
    before :each do
      @maze = Automaze::Automaze.new
    end

    describe "panels" do
      it "returns wall panel when panel is nil" do
        @maze.panels(-123, -456).wall?.should be_true
      end
      it "returns wall panel when panel is floor" do
        @maze.panels(-123, -456).set_kind(:floor)
        @maze.panels(-123, -456).floor?.should be_true
      end
    end

  end
end

