--- A simple, pure lua string buffer implemented with tables
-- @classmod strbuffer
-- @usage
-- local strbuffer = requier 'strbuffer'
-- local buf = strbuffer(", ")
-- buff << "Hello" << "World!"
-- print(buf)

local strbuffer = {}
local __meta

local function new(separator)
	return setmetatable({separator = separator, n = 0, len = 0}, __meta)
end

--- Appends one or more strings to the buffer.
function strbuffer:append(str, ...)
	str = tostring(str)
	self[self.n+1] = str
	self.n = self.n + 1
	self.len = self.len + #str
	if ... then
		self:append(...)
	end
	self.str = nil
	return self
end

--- Helper that returns a partial application of the `append` function that doesn't require the `self` argument.
-- Note: The created closure is cached internally so repeatedly calling this method in a hot loop should not break JIT.
-- @treturn function Appender function for this buffer
function strbuffer:appender()
	self.__appender = self.__appender or function(...)
		return self:append(...)
	end
	return self.__appender
end

-- Truncates a buffer to the first `length` strings.
function strbuffer:truncate(length)
	length = length or 0
	for i=length+1,self.n do
		self.len = self.len - #self[i]
		self[i] = nil
	end
	self.n = length
	self.str = nil
end

--- Concatenates a buffer into a single string.
-- For the configured separator of the buffer, the result is cached.
-- @tparam string separator Separator between the strings
function strbuffer:concat(separator)
	separator = separator or self.separator
	if not self.str or separator~=self.separator then
		self.str = table.concat(self, separator)
	end
	return self.str
end

--- Combines two string buffers into a new one.
local function combine(a, b)
	local combined = new(type(a)=="table" and a.separator or b.separator)
	if type(a)=="table" then for i=1,#a do combined:append(a[i]) end else combined:append(a) end
	if type(b)=="table" then for i=1,#b do combined:append(b[i]) end else combined:append(b) end
	return combined
end

__meta = {
	__index=strbuffer;
	__tostring=strbuffer.concat;
	__concat=combine;
	__add=combine;
	__shl=strbuffer.append;
}

return new
