macro define_accessor(x, source)
	def {{x}}
		{{source}}
	end

	def {{x}} (value)
		{{source}} = value 
	end
end