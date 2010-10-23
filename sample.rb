require_relative "automaze"

algorithm = ARGV[0] || :dug_tunnels
maze = Automaze::Automaze.new(
  :algorithm=>algorithm,
  :size_x=>40,
  :size_y=>30)
puts maze

