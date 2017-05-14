require "../libs/vector/v4.cr"

p1 = V4.new 0.0, 0.0, 0.0, 0.0
p2 = V4.new x:1.0
p3 = V4.new y:1.0
p4 = V4.new z:1.0

puts "p1 :       #{p1}"
puts "p2 :       #{p2}"
puts "p3 :       #{p3}"
puts "p4 :       #{p4}"
puts "-p4 :      #{-p4}"
puts "p4 + p3 :  #{p2 + p3}"
puts "p4 - p3 :  #{p4 - p3}"
puts "p2 * 4 :   #{p2.scale(4.0)}"

p2.set 1.0, 2.0, 3.0, 0.0
p2.set V4Mask::W, 6.7

puts "p2 modif : #{p2}"

p5 = p2.swizzle(Swizzle::XXXX)

puts p5

puts p5.x
puts p5.y
puts p5.z
puts p5.w
