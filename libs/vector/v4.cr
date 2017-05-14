require "./v4Mask.cr"
require "../utils/macroAccessor.cr"

class V4

	@data = [0.0, 0.0, 0.0, 0.0]

	define_accessor(x, @data[0])
	define_accessor(y, @data[1])
	define_accessor(z, @data[2])
	define_accessor(w, @data[3])

	# constructor
	def initialize(x = 0.0, y  = 0.0, z  = 0.0, w = 0.0)
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

	# scale the vector by a scalar
	def scale(s : Number)
		@data[0] *= s
		@data[1] *= s
		@data[2] *= s
		@data[3] *= s
		self #return itself
	end

	def set(x, y, z, w)
		@data[0] = x
		@data[1] = y
		@data[2] = z
		@data[3] = w
	end

	def set(mask : V4Mask, v : Number)
		@data[mask.value] = v
	end

	def sets(*values : Tuple(V4Mask, Number))
		values.each do |tuple|
			set tuple[0], tuple[1]
		end
	end

	def get(mask : V4Mask)
		@data[mask.value]
	end

	def copy
		V4.new x, y, z, w
	end

	def copy(mask : Tuple(V4Mask, V4Mask, V4Mask, V4Mask))
		V4.new @data[mask[0].value], @data[mask[1].value], @data[mask[2].value], @data[mask[3].value]
	end

	def to_s(io)
		io << "[" << x << "," << y << "," << z << "," << w << "]"
	end
end