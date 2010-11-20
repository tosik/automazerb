# encoding: utf-8
module Boutaoshi
  def init_panels
    each_panels do |panel, x, y|
      panel.set_kind(:floor)
      panel.set_kind(:wall) if post?(x,y)
    end
  end

  def generate
    init_panels

    each_panels do |panel, x, y|
      if post?(x,y) && y == 2
        random_floor(four_panels(x,y)).set_kind(:wall)
      end
    end

    each_panels do |panel, x, y|
      if post?(x,y) && y != 2
        random_floor(three_panels(x,y)).set_kind(:wall)
      end
    end
  end

  def post?(x,y)
    ( x % 2 ) == 1 && ( y % 2 ) == 1
  end
end

