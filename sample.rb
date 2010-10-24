require_relative "automaze"

algorithm = ARGV[0] || :dug_tunnels
maze = Automaze::Automaze.new(
  :algorithm=>algorithm,
  :size_x=>40,
  :size_y=>30)

# building rooms
5.times do
  room_size_x = rand(2) * 2 + 1
  room_size_y = rand(2) * 2 + 1
  center_x = rand(maze.size_x/2-room_size_x)*2 + room_size_x
  center_y = rand(maze.size_y/2-room_size_y)*2 + room_size_y
  (-room_size_x..room_size_x).each do |x|
    (-room_size_y..room_size_y).each do |y|
      maze.panels(x+center_x,y+center_y).set_kind(:floor)
    end
  end
end

puts maze

