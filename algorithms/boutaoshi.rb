# coding: utf-8

module Boutaoshi
  def generate
    init_panels
  end

  def init_panels
    (0..@size_y).each {|y|
      (0..@size_x).each {|x|
        panels(x,y).set_kind(:floor)
        panels(x,y).set_kind(:wall) if post?(x,y)
      }
    }
  end

  def post?(x,y)
    ( x % 2 ) == 1 && ( y % 2 ) == 1
  end
end

