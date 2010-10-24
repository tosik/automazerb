# coding: utf-8

require_relative "../lib/panel"

describe Automaze::Panel do
  describe "check kind of panel; exp) wall?, floor?" do
    it "returns true when correct kind" do
      Automaze::Panel.new(:wall).wall?.should be_true
      Automaze::Panel.new(:floor).floor?.should be_true
    end
    it "returns true when incorrect kind" do
      Automaze::Panel.new(:floor).wall?.should be_false
      Automaze::Panel.new(:wall).floor?.should be_false
    end
  end

  describe "new by invalid kind" do
    it "raises error" do
      lambda { Automaze::Panel.new(:this_is_invalid_kind) }.should raise_error
    end
  end

  describe "instance" do
    before :each do
      @wall = Automaze::Panel.new(:wall)
      @floor = Automaze::Panel.new(:floor)
    end

    describe "set_kind" do
      it "can set kind" do
        @wall.set_kind(:floor)
        @wall.floor?.should be_true
        @floor.set_kind(:wall)
        @floor.wall?.should be_true
      end
    end
  end
end

