require "../libs/vector/v4.cr"

p1 = V4.new 0.0, 0.0, 0.0, 0.0
p2 = V4.new x: 1.0
p3 = V4.new y: 1.0
p4 = V4.new z: 1.0

puts "p1 :       #{p1}"
puts "p2 :       #{p2}"
puts "p3 :       #{p3}"
puts "p4 :       #{p4}"
puts "-p4 :      #{-p4}"
puts "p4 + p3 :  #{p2 + p3}"
puts "p4 - p3 :  #{p4 - p3}"
puts "p2 * 4 :   #{p2.scale(4.0)}"

p2.set(1.0, 2.0, 3.0, 0.0)
puts "p2 modif : #{p2}"

p2.x(7.7)
p2.sets({V4Mask::Y, 1.2}, {V4Mask::Z, 7.32})
p2.set(V4Mask::W, 6.7)
puts "p2 modif : #{p2}"

p5 = p2.copy(swizzle(X, X, Y, Z))

puts "p5 = p2.xxyz #{p5}"

puts "p5.x #{p5.x}  #{p5.get(V4Mask::X)}"
puts "p5.y #{p5.y}  #{p5.get(V4Mask::Y)}"
puts "p5.z #{p5.z}  #{p5.get(V4Mask::Z)}"
puts "p5.w #{p5.w}  #{p5.get(V4Mask::W)}"

p6 = V4.new(p5)
puts "p6 #{p6}"
puts p5.x
puts p5.y
puts p5.z
puts p5.w

puts p5*3
puts p5.scale(3)
puts p5
puts p6 == p5
puts p6*p3
