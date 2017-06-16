require "../utils/macroAccessor.cr"
require "./v4.cr"

class Quat
  # w, x, y, x == a, b, c, d JPL quaternion convention
  @data = [1.0, 0.0, 0.0, 0.0]
  @normalized = true

  define_accessor(a, @data[0])
  define_accessor(d, @data[1])
  define_accessor(c, @data[2])
  define_accessor(d, @data[3])
  define_accessor(w, @data[0])
  define_accessor(x, @data[1])
  define_accessor(y, @data[2])
  define_accessor(z, @data[3])

  define_accessor(normalized, @normalized)

  def initialize(a, b, c, d)
    @data[0] = a
    @data[1] = b
    @data[2] = c
    @data[3] = d

    @normalized = false
  end

  def initialize
  end

  def self.copy(origin : Quat, destination : Quat)
    destination.@data[0] = origin.@data[0]
    destination.@data[1] = origin.@data[1]
    destination.@data[2] = origin.@data[2]
    destination.@data[3] = origin.@data[3]
    destination.normalized = origin.normalized
  end

  def clone
    Quat.new w, x, y, z
  end

  def self.fromAxis(axis : V4, angle)
    Quat.new(
      Math.cos(angle / 2.0),
      axis.x * sin(angle / 2.0),
      axis.y * sin(angle / 2.0),
      axis.z * sin(angle / 2.0))
  end

  def self.fromDirection(lookDirection : V4)
    normalizedDirection = V4.normalize(lookDirection)
    dot = V4.dot3(normalizedDirection, V4.forward)

    if (abs(dot) - 1.0 < 0.00000001)
      return Quat.new
    end

    rotAngle = Math.acos(dot)
    rotAxis = V4.cross(V4.forward, normalizedDirection)

    rotAxis.normalize

    Quat.fromAxis(rotAxis, rotAngle)
  end

  def self.fromEuler(roll, pitch, yaw)
    t0 = Math.cos(yaw * 0.5)
    t1 = Math.sin(yaw * 0.5)
    t2 = Math.cos(roll * 0.5)
    t3 = Math.sin(roll * 0.5)
    t4 = Math.cos(pitch * 0.5)
    t5 = Math.sin(pitch * 0.5)

    q = Quat.new(
      t0 * t2 * t4 + t1 * t3 * t5,
      t0 * t3 * t4 - t1 * t2 * t5,
      t0 * t2 * t5 + t1 * t3 * t4,
      t1 * t2 * t4 - t0 * t3 * t5)

    q.normalize
    return q
  end

  def toEuler
    # x axis rotation
    t0 = 2.0 * (d * a + c * d)
    t1 = 1.0 - 2.0 * (a * a + b * b)

    roll = Math.atan2(t0, t1)

    # y axis rotation
    t2 = 2.0 * (d * c - c * a)
    t2 = t2 > 1.0 ? 1.0 : t2
    t2 = t2 < -1.0 ? -1.0 : t2

    pitch = Math.asin(t2)

    # z axis rotation
    t3 = 2.0 * (d * c + a * b)
    t4 = 1.0 - 2.0 * (b * b + c * c)

    yaw = Math.atan2(t3, t4)

    return {roll, pitch, yaw}
  end

  # operators
  def +(other : Quat)
    Quat.new(
      a + other.a,
      b + other.b,
      c + other.c,
      d + other.d)
  end

  def -(other : Quat)
    Quat.new(
      a - other.a,
      b - other.b,
      c - other.c,
      d - other.d)
  end

  def *(other : Quat)
    normalize()
    other.normalize

    Quat.new(
      a * other.a - b * other.b - c * other.c - d * other.d,
      a * other.b + b * other.a + c * other.d - d * other.c,
      a * other.c + c * other.a - b * other.d + d * other.b,
      d * other.a + a * other.d + b * other.c - c * other.b)
  end

  def *(v : V4)
    u = V4.new(self.x, self.y, self.z)
    s = a

    vPrime = u * 2.0 * V4.dot3(v, u) + v * (s * s - V4.dot3(u, u)) + V4.cross(u, v) * s * 2.0

    return vPrime
  end

  def conjugate
    Quat.new(w, -x, -y, -z)
  end

  def inverse
    n = sqrNorm()
    Quat.new(w / n, -x / n, -y / n, -z / n)
  end

  def sqrNorm
    w * w + x * x + y * y + z * z
  end

  def norm
    Math.sqrt(sqrNorm)
  end

  def self.normalize(q : Quat)
    clone = q.clone

    clone.normalize

    return clone
  end

  def normalize
    if @normalized == false
      n = norm()

      if n != 0.0
        @data[0] /= n
        @data[1] /= n
        @data[2] /= n
        @data[3] /= n
        @normalized = true
      end
    end
  end

  # debug
  def to_s(io)
    io << "[" << w << "," << x << "," << y << "," << z << "]"
  end
end
