# coding: utf-8

require_relative "../automaze"

describe Automaze, "say" do
  it "returns hello string" do
    Automaze.say.should eql "hello"
  end
end

