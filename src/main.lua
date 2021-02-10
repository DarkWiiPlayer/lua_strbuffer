--- A simple, pure lua string buffer implemented with tables
-- @module strbuffer

local strbuffer = {}
local __meta

local function new(char)
	return setmetatable({char = char, n = 0, len = 0}, __meta)
end

function strbuffer:append(value, ...)
	value = tostring(value)
	self[self.n+1] = value
	self.n = self.n + 1
	self.len = self.len + #value
	if ... then
		self:append(...)
	end
	self.str = nil
	return self
end

function strbuffer:truncate(length)
	length = length or 0
	for i=length+1,self.n do
		self.len = self.len - #self[i]
		self[i] = nil
	end
	self.n = length
	self.str = nil
end

function strbuffer:concat(char)
	char = char or self.char
	if not self.str or char~=self.char then
		self.str = table.concat(self, char)
	end
	return self.str
end

local combine = function(a, b)
	local new = new(type(a)=="table" and a.char or b.char)
	if type(a)=="table" then for i=1,#a do new:append(a[i]) end else new:append(a) end
	if type(b)=="table" then for i=1,#b do new:append(b[i]) end else new:append(b) end
	return new
end;

__meta = {
	__index=strbuffer;
	__tostring=strbuffer.concat;
	__concat=combine;
	__add=combine;
}

return new
