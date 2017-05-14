enum V4Mask
	X = 0
	Y = 1
	Z = 2
	W = 3
end

macro swizzle(a, b, c, d)
	{V4Mask::{{a}}, V4Mask::{{b}}, V4Mask::{{c}}, V4Mask::{{d}}}
end
