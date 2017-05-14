require "./v4Mask.cr"
require "../utils/macroAccessor.cr"

class V4
  @data = [0.0, 0.0, 0.0, 1.0]

  define_accessor(x, @data[0])
  define_accessor(y, @data[1])
  define_accessor(z, @data[2])
  define_accessor(w, @data[3])

  # constructor
  def initialize(x = 0.0, y = 0.0, z = 0.0, w = 1.0)
    @data[0] = x
    @data[1] = y
    @data[2] = z
    @data[3] = w
  end

  # Constructor by copy
  def initialize(other : V4)
    self.set(other.x, other.y, other.z, other.w)
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

  # equals boolean
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
    self # return itself
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

  # Cross product
  def *(v : V4)
    vResult = V4.new
    vResult.x ((self.y * v.z) - (self.z * v.y))
    vResult.y ((self.z * v.x) - (self.x * v.z))
    vResult.z ((self.x * v.y) - (self.y * v.x))
    return vResult
  end

  # Dot product on V3
  def dot3(v : V4)
    vResult = V4.new
    a = self.x * v.x
    b = self.y * v.y
    c = self.z * v.z
    result = a + b + c
    return result
  end

  # Dot product on V2
  def dot2(v : V4, coord1 = V4Mask::X, coord2 = V4Mask::Y)
    a = self.get(coord1)*v.get(coord1)
    b = self.get(coord2)*v.get(coord2)
    result = a + b
    return result
  end

  def to_s(io)
    io << "[" << x << "," << y << "," << z << "," << w << "]"
  end
end
