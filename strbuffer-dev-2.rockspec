package = "strbuffer"
version = "dev-2"
source = {
	url = "git://github.com/DarkWiiPlayer/lua_strbuffer";
}
description = {
	summary = "A simple, pure lua string buffer using tables";
	detailed = ([[
		A small library providing a simple string buffer object that strings and other values can be appended to.
	]]):gsub("\t", "");
	homepage = "https://github.com/darkwiiplayer/lua_strbufer";
	license = "Unlicense";
}
dependencies = {
	"lua >= 5.1";
}
build = {
	type = "builtin";
	modules = {
		strbuffer = "src/strbuffer.lua"
	};
}
