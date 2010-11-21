$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "automaze"

started = Time.now
maze = Automaze::Automaze.new(
  :algorithm=>:dug_tunnels,
  :size_x=>50,
  :size_y=>50)

puts "#{Time.now - started} seconds"


