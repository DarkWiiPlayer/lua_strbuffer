strbuffer = require "strbuffer"

describe "string buffer", ->
	local buffer

	before_each ->
		buffer = strbuffer(' ')

	it "should accept strings", ->
		assert.no.error -> buffer\append "Hello World"
	
	it "should concatenate correctly", ->
		buffer\append "Hello"
		buffer\append "World"
		assert.equal "Hello World", buffer\concat!
		assert.equal "Hello+World", buffer\concat "+"
	
	it "should work with tostring()", ->
		buffer\append "Hello"
		buffer\append "World"
		assert.equal "Hello World", tostring(buffer)

	it "should accept multiple strings", ->
		buffer\append "Hello", "World"
		assert.equal buffer\concat!, "Hello World"
	
	describe "concatenation", ->
		it "should work with ..", ->
			buffer\append "word"
			assert.equal "prefix word suffix", tostring("prefix"..buffer.."suffix")
			assert.equal "word 12", tostring(buffer .. "1" .. "2")

		it "should work with +", ->
			buffer\append "word"
			assert.equal "prefix word suffix", tostring("prefix" + buffer + "suffix")
			assert.equal "word 1 2", tostring(buffer + "1" + "2")
	
	describe 'truncating', ->
		it "should work on empty buffers", ->
			assert.has.no.errors, ->
				strbuffer!\truncate(0)
