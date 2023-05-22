local task = require("spooder").task

task.test {
	description = "Runs tests and builds documentation.";
	"luacheck .";
	"busted .";
	"ldoc .";
}
