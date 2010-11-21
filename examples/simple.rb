$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "automaze"

maze = Automaze::Automaze.new(:size_x=>40, :size_y=>30)

puts maze

