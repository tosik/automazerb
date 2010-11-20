# encoding: utf-8
require 'helper'

class TestAutomaze < Test::Unit::TestCase
  context "check kind of panel; exp) wall?, floor?" do
    should "returns true when correct kind" do
      assert Automaze::Panel.new(:wall).wall?
      assert Automaze::Panel.new(:floor).floor?
    end
    should "returns true when incorrect kind" do
      assert !Automaze::Panel.new(:floor).wall?
      assert !Automaze::Panel.new(:wall).floor?
    end
  end

  context "new by invalid kind" do
    should "raises error" do
      assert_raise(RuntimeError) { Automaze::Panel.new(:this_is_invalid_kind) }
    end
  end

  context "instance" do
    setup do
      @wall = Automaze::Panel.new(:wall)
      @floor = Automaze::Panel.new(:floor)
    end

    context "set_kind" do
      should "can set kind" do
        @wall.set_kind(:floor)
        assert @wall.floor?
        @floor.set_kind(:wall)
        assert @floor.wall?
      end
    end
  end
end

