# Lua String Buffers

## Usage

	strbuffer = require 'strbuffer'
	local buf = strbuffer()

	buf:append('the', 'answer', 'is', 42) -- Multiple arguments allowed, everything gets `tostring`ed

	buf:concat('-')
	--> 'the-answer-is-42'

	tostring(buf)
	--> 'theansweris42'
	-- syntactic sugar for buf:concat()

	-- Line buffer (concatenated with newline by default)
	local document = strbuffer('\n'):append("Heading")

	print(document + "line 1" + "line 2")
	--> Heading
	--> line 1
	--> line 2
