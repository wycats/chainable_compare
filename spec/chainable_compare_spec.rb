require "spec_helper"

class ComparableInteger
  include ChainablyComparable

  attr_accessor :number

  def initialize(number)
    @number = number
  end

  def <=>(other)
    @number <=> other.number
  end
end

describe "chainable compare" do
  def int(integer)
    ComparableInteger.new(integer)
  end

  it "works for 1 < x < 5 when x is 3" do
    x = int(3)
    (int(1) < x < int(5)).should be_true
  end

  it "works for 1 < x < 5 when x is 0" do
    x = int(0)
    (int(1) < x < int(5)).should be_false
  end

  it "works for 1 < x < 5 when x is 6" do
    x = int(6)
    (int(1) < x < int(5)).should be_false
  end

  it "works for 10 > x <= 9 where x = 7" do
    x = int(7)
    (int(10) > x <= int(9)).should be_true
  end

  it "works for 10 > x <= 9 where x = 10" do
    x = int(10)
    (int(10) > x <= int(9)).should be_false
  end
end