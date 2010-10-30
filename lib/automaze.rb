# coding: utf-8

# The MIT License
#
# Copyright (c) 2010 Toshiyuki Hirooka <toshi.hirooka@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require "active_support/inflector"
require "panel"

module Automaze
  class Automaze
    DEFAULT_ALGORITHM = :boutaoshi

    class << self
      def include_algorithm(algorithm)
        raise "cannot include because algorithm is nil" if algorithm.nil?
        require_relative "algorithms/#{algorithm.to_s}"
        include algorithm.to_s.camelize.constantize
      end
    end

    def initialize(options={})
      @panels = {}

      @size_x = options.delete(:size_x) || 30
      @size_y = options.delete(:size_y) || 20
      self.class.include_algorithm options.delete(:algorithm) || DEFAULT_ALGORITHM
      self.generate # included algorithm
    end
    attr_reader :size_x
    attr_reader :size_y

    # nil panel is wall
    def panels(x,y)
      @panels[[x,y]] ||= Panel.new(:wall)
    end

    def each_panels
      (0..@size_y).each do |y|
        (0..@size_x).each do |x|
          yield(panels(x,y), x, y)
        end
      end
    end

    def four_panels(x,y)
      [
        panels(x-1,y),
        panels(x+1,y),
        panels(x,y-1),
        panels(x,y+1),
      ]
    end

    def three_panels(x,y)
      [
        panels(x-1,y),
        panels(x+1,y),
        panels(x,y+1),
      ]
    end

    def random_floor(panels)
      loop do
        panel = panels[rand(panels.length)]
        return panel if panel.floor?
      end
    end

    def out_of_map?(x, y)
      return true if x < 0
      return true if x > @size_x
      return true if y < 0
      return true if y > @size_y
      return false
    end

    def to_s
      str = ""
      (-1..@size_y+1).each {|y|
        (-1..@size_x+1).each {|x|
          if panels(x,y).wall?
            str += "XX"
          else
            str += "  "
          end
        }
        str += "\n"
      }
      return str
    end
  end
end

