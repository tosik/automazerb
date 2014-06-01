# encoding: utf-8
module Automaze
  class OddLengthMaze < Exception; end

  class Automaze
    DEFAULT_ALGORITHM = :dug_tunnels

    class << self
      def include_algorithm(algorithm)
        raise "cannot include because algorithm is nil" if algorithm.nil?
        case algorithm
        when :dug_tunnels
          include DugTunnels
        when :boutaoshi
          include Boutaoshi
        end
      end
    end

    def initialize(options={})
      @size_x = options.delete(:size_x) || 30
      @size_y = options.delete(:size_y) || 20
      raise OddLengthMaze if @size_x % 2 == 1 || @size_y % 2 == 1
      initialize_panels

      self.class.include_algorithm(options.delete(:algorithm) || DEFAULT_ALGORITHM)
      self.generate # included algorithm
    end
    attr_reader :size_x
    attr_reader :size_y

    # nil panel is wall
    def panels(x,y)
      dest = @panels[x][y]
      raise if dest.nil?
      dest
    rescue
      @outer_panel ||= Panel.new(:wall)
    end

    def initialize_panels
      @panels = Array.new(@size_y).map { Array.new(@size_x, nil) }
      each_panels do |panel, x, y|
        @panels[x][y] = Panel.new(:wall) if @panels[x]
      end
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

    def even_hash_panels
      @panels.select {|xy, panel|
        xy[0] % 2 == 0 && xy[1] % 2 == 0
      }
    end

    def random_floor(panels)
      floors = panels.select {|panel| panel.floor?}
      raise "no floors" if floors.empty?
      floors[rand(floors.length)]
    end

    def random_even_xy
      [rand((@size_x/2).to_i + 1) * 2, rand((@size_y/2).to_i + 1) * 2]
    end

    def random_floor_xy(hash_panels)
      floors = hash_panels.select {|xy, panel| panel.floor?}
      raise "no floors" if floors.empty?
      return floors.to_a.first.first if floors.length == 1
      floors.to_a[rand(floors.length)].first
    end

    def out_of_map?(x, y)
      return true if x < 0
      return true if x > @size_x
      return true if y < 0
      return true if y > @size_y
      return false
    end

    def to_s
      (-1..@size_y+1).map {|y|
        (-1..@size_x+1).map {|x|
          if panels(x,y).wall?
            "XX"
          else
            "  "
          end
        }.join + "\n"
      }.join
    end
  end
end

