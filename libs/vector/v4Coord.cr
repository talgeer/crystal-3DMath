enum V4Coord
	X = 0
	Y = 1
	Z = 2
	W = 3
end

macro swizzle(a, b, c, d)
	[V4Coord::{{a}}, V4Coord::{{b}}, V4Coord::{{c}}, V4Coord::{{d}}]
end

macro swizzle(a, b, c)	
	[V4Coord::{{a}}, V4Coord::{{b}}, V4Coord::{{c}}]
end

macro swizzle(a, b)
	[V4Coord::{{a}}, V4Coord::{{b}}]
end

macro swizzle(a)
	[V4Coord::{{a}}]
end