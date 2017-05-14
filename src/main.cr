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
p2.sets({V4Coord::Y, 1.2}, {V4Coord::Z, 7.32})
p2.set(V4Coord::W, 6.7)
puts "p2 modif : #{p2}"

p5 = p2.clone(swizzle(X, X, Y, Z))

puts "p5 = p2.xxyz #{p5}"

puts "p5.x #{p5.x}  #{p5.get(V4Coord::X)}"
puts "p5.y #{p5.y}  #{p5.get(V4Coord::Y)}"
puts "p5.z #{p5.z}  #{p5.get(V4Coord::Z)}"
puts "p5.w #{p5.w}  #{p5.get(V4Coord::W)}"

puts p5
p7 = p5.map(swizzle(X, Y, Z)) {|a| (a + 1.14) * 6.3}
p8 = p5.map {|a| (a + 1.14) * 6.3}
p6 = p5.clone

p10 = V4.new

V4.copy(swizzle(X, X, Z, Z), p6, p10)

puts p10
puts p7
puts p8
puts p6 == p5
puts V4.cross(p6, p3)
puts "p5 = #{p5}"
puts "p4 = #{p4}"

puts V4.dot3(p4, p5)
puts V4.dot2(p4, p5, V4Coord::X, V4Coord::Z)
puts V4.tripleProd(p2, p3, p4)
puts p5.reduce {|a| a}
puts p7.reduce(swizzle(W)) {|a| a * a}
puts p7.reduce(swizzle(Z)) {|a| a * a}
puts p7.reduce(swizzle(X)) {|a| a * a}
puts p7.reduce(swizzle(X, X)) {|a| a * a}
puts p7.reduce {|a| a * a}
