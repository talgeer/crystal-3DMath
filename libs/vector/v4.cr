require "./V4Coord.cr"
require "../utils/macroAccessor.cr"

class V4
	@data = [0.0, 0.0, 0.0, 1.0]

	define_accessor(x, @data[0])
	define_accessor(y, @data[1])
	define_accessor(z, @data[2])
	define_accessor(w, @data[3])

	# constructor
	def initialize(x = 0.0, y  = 0.0, z  = 0.0, w = 1.0)
		@data[0] = x
		@data[1] = y
		@data[2] = z
		@data[3] = w
	end

	# Constructor by copy
	def initialize(other : V4)
		set(other.x, other.y, other.z, other.w)
	end

	# set values one after another
	def set(x, y, z, w)
		@data[0] = x
		@data[1] = y
		@data[2] = z
		@data[3] = w
	end

	# addition operator
	def +(other : V4)
		V4.new(x + other.x, y + other.y, z + other.z, w + other.w)
	end

	# substraction operator
	def -(other : V4)
		V4.new(x - other.x, y - other.y, z - other.z, w - other.w)
	end

	# inverse operator
	def -
		V4.new(-x, -y, -z, -w)
	end

 	#equals boolean
  	def ==(other : V4)
    	return (self.x == other.x) && (self.y == other.y) && (self.z == other.z) && (self.w == other.w)
  	end

  	# different boolean
  	def !=(other : V4)
    	!(self == other)
  	end

  	# return a scaled vector
  	def *(s : Number)
  		result = V4.new(self)
  	 	result.scale(s)
  	 	return result
  	end
 
	# scale the vector by a scalar
	def scale(s : Number)
		@data[0] *= s
		@data[1] *= s
		@data[2] *= s
		@data[3] *= s
	end

	# set one value using V4Coord
	def set(mask : V4Coord, v : Number)
		@data[mask.value] = v
	end

	# set several value using V4Coord
	def sets(*values : Tuple(V4Coord, Number))
		values.each do |tuple|
			set tuple[0], tuple[1]
		end
	end

	def get(mask : V4Coord)
		@data[mask.value]
	end

	def gets(*values : Tuple(V4Coord, Number))
		values.each do |tuple|
			tuple[1] = get(tuple[0])
		end
	end

	# Cross product
	def self.cross(v1 : V4, v2 : V4)
		V4.new(
			(v1.y * v2.z) - (v1.z * v2.y),
			(v1.z * v2.x) - (v1.x * v2.z),
			(v1.x * v2.y) - (v1.y * v2.x))
	end

	# Dot product on V3
	def self.dot3(v1 : V4, v2 : V4)
		v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
	end

	# Dot product on V2
	def self.dot2(v1 : V4, v2 : V4, coord1 = V4Coord::X, coord2 = V4Coord::Y)
		v1.get(coord1) * v2.get(coord1) + v1.get(coord2) * v2.get(coord2)
	end

	# Triple product on V3
	def self.tripleProd(v1 : V4, v2 : V4, v3 : V4)
		V4.dot3(V4.cross(v1, v2), v3)
	end

	#copy
	def self.copy(origin : V4, dstination : V4)
		destination.@data[0] = origin.@data[0]
		destination.@data[1] = origin.@data[1]
		destination.@data[2] = origin.@data[2]
		destination.@data[3] = origin.@data[3]
	end

	def self.copy(swizzleMask, origin : V4, destination : V4)
		destination.set(0.0, 0.0, 0.0, 0.0)
		i = 0

		swizzleMask.each do |dimension|
			destination.@data[i] = origin.get(dimension)
			i += 1
		end
	end

	def clone
		V4.new x, y, z, w
	end

	def clone(swizzleMask)
		v = V4.new
		i = 0

		swizzleMask.each do |dimension|
			v.@data[i] = get(dimension)
			i += 1
		end
		v
	end

	#map
	def map
		v = V4.new

		v.@data[0] = yield @data[0]
		v.@data[1] = yield @data[1]
		v.@data[2] = yield @data[2]
		v.@data[3] = yield @data[3]

		v
	end

	def map(mask)
		v = V4.new
		i = 0
		mask.each do |dimension|
			v.@data[i] = yield get(dimension)
			i += 1
		end
		v
	end

	def reduce
		a = 0.0

		@data.each do |elt|
			a += yield elt
		end

		a
	end

	def reduce(mask)
		a = 0.0
		mask.each do |dimension|
			a += yield get(dimension)
		end
		a
	end

	# debug
	def to_s(io)
		io << "[" << x << "," << y << "," << z << "," << w << "]"
	end
end
