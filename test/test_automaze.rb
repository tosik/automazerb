# encoding: utf-8
require 'helper'

class TestAutomaze < Test::Unit::TestCase
  context "self.include_algorithm" do
    should "includes algorithm module" do
      assert_nothing_raised() { Automaze::Automaze.include_algorithm(:boutaoshi) }
      assert Automaze::Automaze.included_modules.include?(Boutaoshi)
    end
  end

  context "new" do
    should "returns Automaze class" do
      assert_equal Automaze::Automaze, Automaze::Automaze.new.class
    end

    context "using options" do
      context ":algorithm" do
        should "accepts :boutaoshi" do
          assert_nothing_raised() { Automaze::Automaze.new(:algorithm=>:boutaoshi) }
        end
        should "doesnt accept :invalid_algorithm" do
          assert_raise(LoadError) { Automaze::Automaze.new(:algorithm=>:invalid_algorithm) }
        end
      end
    end
  end

  context "instance" do
    setup do
      @maze = Automaze::Automaze.new
    end

    context "panels" do
      should "returns wall panel when panel is nil" do
        assert @maze.panels(-123, -456).wall?
      end
      should "returns wall panel when panel is floor" do
        @maze.panels(-123, -456).set_kind(:floor)
        assert @maze.panels(-123, -456).floor?
      end
    end
  end
end
