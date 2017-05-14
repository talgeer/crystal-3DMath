require "../libs/vector/v4.cr"

p1 = V4.new 0.0, 0.0, 0.0, 0.0
p2 = V4.new x: 1.0
p3 = V4.new y: 1.0
p4 = V4.new z: 1.0

puts "initial vectors"
puts "_______________________"
puts "p1 :       #{p1}"
puts "p2 :       #{p2}"
puts "p3 :       #{p3}"
puts "p4 :       #{p4}"
puts "_______________________"
puts ""
puts "operators"
puts "_______________________"
puts "-p4 :      #{-p4}"
puts "p4 + p3 :  #{p2 + p3}"
puts "p4 - p3 :  #{p4 - p3}"
puts "p2 * 4 :   #{p2 * (4.0)}"
puts "p2.scale(4.0):   #{p2.scale(4.0)}"
puts ""
puts " setters"
puts "_______________________"
p2.set(1.0, 2.0, 3.0, 0.0)
puts "p2 modif : #{p2}"
puts "p2.x(7.7) : #{p2.x(7.7)}"
puts "-----------"
puts "sets with masks"
p2.sets({V4Coord::Y, 1.2}, {V4Coord::Z, 7.32})
p2.set(V4Coord::W, 6.7)
puts "p2 modif : #{p2}"

p5 = p2.clone(swizzle(X, X, Y, Z))

puts "p5 = p2.xxyz #{p5}"

puts "p5.x #{p5.x}  #{p5.get(V4Coord::X)}"
puts "p5.y #{p5.y}  #{p5.get(V4Coord::Y)}"
puts "p5.z #{p5.z}  #{p5.get(V4Coord::Z)}"
puts "p5.w #{p5.w}  #{p5.get(V4Coord::W)}"

puts " p5 #{p5}"
p7 = p5.map(swizzle(X, Y, Z)) { |a| (a + 1.14) * 6.3 }
puts "p7 #{p7}"
p8 = p5.map { |a| (a + 1.14) * 6.3 }
puts "p8 #{p8}"
puts ""
puts "copy"
puts "_______________________"
puts "clone"
p6 = p5.clone
puts "p6 #{p6}"
p10 = V4.new
puts "copy"
V4.copy(swizzle(X, X, Z, Z), p6, p10)

puts "p10 #{p10}"
puts "p7 #{p7}"
puts "p8 #{p8}"
puts ""
puts "complex operators"
puts "_______________________"
puts "p6 == p5 #{p6 == p5}"
puts "p6 cross p3 #{V4.cross(p6, p3)}"
puts ""
puts "dot product"
puts "--------"
puts "p5 = #{p5}"
puts "p4 = #{p4}"
puts "p4 dot p5"
puts V4.dot3(p4, p5)
puts "p4 dot2 p5 (x,z)"
puts V4.dot2(p4, p5, V4Coord::X, V4Coord::Z)
puts "--------"
puts "triple product p2 p3 p4"
puts V4.tripleProd(p2, p3, p4)
puts ""
puts "reduce"
puts "_______________________"
puts p5.reduce { |a| a }
puts p7.reduce(swizzle(W)) { |a| a * a }
puts p7.reduce(swizzle(Z)) { |a| a * a }
puts p7.reduce(swizzle(X)) { |a| a * a }
puts p7.reduce(swizzle(X, X)) { |a| a * a }
puts p7.reduce { |a| a * a }
puts "--------"
