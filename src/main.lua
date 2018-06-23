--- A simple, pure lua string buffer implemented with tables
-- @module strbuffer

local strbuffer = {}
local __meta

local function new(char)
	return setmetatable({char = char}, __meta)
end

function strbuffer:append(value, ...)
	self[#self+1] = tostring(value)
	if select('#', ...) > 0 then
		self:append(...)
	end
	return self
end

function strbuffer:concat(char)
	char = char or self.char
	return table.concat(self, char)
end

local combine = function(a, b)
	local new = new(type(a)=="table" and a.char or type(b)=="table" and b.char)
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
