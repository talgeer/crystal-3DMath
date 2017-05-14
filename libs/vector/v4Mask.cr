enum V4Mask
	X = 0
	Y = 1
	Z = 2
	W = 3
end

module Swizzle
	XXXX = {V4Mask::X, V4Mask::X, V4Mask::X, V4Mask::X}
	XXXY = {V4Mask::X, V4Mask::X, V4Mask::X, V4Mask::Y}
	XXXZ = {V4Mask::X, V4Mask::X, V4Mask::X, V4Mask::Z}
	XXXW = {V4Mask::X, V4Mask::X, V4Mask::X, V4Mask::W}
end