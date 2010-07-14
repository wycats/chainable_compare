require "spec_helper"

class Fixnum
  include ChainablyComparable
end

describe "chainable compare" do
  it "works for 1 < x < 5 when x is 3" do
    x = 3
    (1 < x < 5).should be_true
  end

  it "works for 1 < x < 5 when x is 0" do
    x = 0
    (1 < x < 5).should be_false
  end

  it "works for 1 < x < 5 when x is 6" do
    x = 6
    (1 < x < 5).should be_false
  end

  it "works for 10 > x <= 9 where x = 7" do
    x = 7
    (10 > x <= 9).should be_true
  end

  it "works for 10 > x <= 9 where x = 10" do
    x = 10
    (10 > x <= 9).should be_false
  end
end