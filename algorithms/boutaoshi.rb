# coding: utf-8

module Boutaoshi
  def generate
    init_panels

    each_panels do |x, y|
      if post?(x,y) && y == 2
        random_floor(four_panels(x,y)).set_kind(:wall)
      end
    end

    each_panels do |x, y|
      if post?(x,y) && y != 2
        random_floor(three_panels(x,y)).set_kind(:wall)
      end
    end
  end

  def init_panels
    each_panels do |x, y|
      panels(x,y).set_kind(:floor)
      panels(x,y).set_kind(:wall) if post?(x,y)
    end
  end

  def post?(x,y)
    ( x % 2 ) == 1 && ( y % 2 ) == 1
  end
end

