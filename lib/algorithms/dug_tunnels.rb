# encoding: utf-8
module DugTunnels
  def init_panels
    each_panels do |panel, x, y|
      panel.set_kind(:wall)
    end
  end

  def generate
    @dug_count = 0
    init_panels

    # start point
    panels(*random_even_xy).set_kind(:floor)

    until dug_all?
      even_floor_panels = []
      each_panels do |panel, x, y|
        if x % 2 == 0 && y % 2 == 0
          even_floor_panels.push([x, y]) if panel.floor?
        end
      end

      xy = even_floor_panels.sample

      while can_dig(*xy)
        dir = random_direction
        next_xy = next_xy(*xy, dir)
        next_panel = panels(*next_xy)
        if next_panel.wall? && !out_of_map?(*next_xy)
          dig(*xy, dir)
          xy = next_xy
        end
      end
    end
  end

  def random_direction
    rand(4)
  end

  def next_xy(x, y, dir)
    [
      [x-2,y],
      [x+2,y],
      [x,y-2],
      [x,y+2],
    ].at(dir)
  end

  def next_panel(x, y, dir)
    panels(*next_xy(x, y, dir))
  end

  def can_dig(x, y)
    (0..3).each do |dir|
      unless out_of_map?(*next_xy(x, y, dir))
        return true if next_panel(x, y, dir).wall?
      end
    end
    return false
  end

  def dug_all?
    @dug_count >= ((size_x) * (size_y) / 4 - 1).to_i
  end

  def dig(x, y, dir)
    xy = next_xy(x, y, dir)
    panels(*xy).set_kind(:floor)
    @dug_count += 1

    diff = [xy[0] - x, xy[1] - y]
    if diff[0] == 0
      panels(x, xy[1] - 1).set_kind(:floor) if diff[1] > 0
      panels(x, xy[1] + 1).set_kind(:floor) if diff[1] < 0
    end
    if diff[1] == 0
      panels(xy[0] - 1, y).set_kind(:floor) if diff[0] > 0
      panels(xy[0] + 1, y).set_kind(:floor) if diff[0] < 0
    end
  end
end

