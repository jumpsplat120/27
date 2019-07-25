socket = require "socket"

math.randomseed(os.time())

text = {}
font = love.graphics.newFont("terminal.ttf")
ta   = 0
tr   = 1/20

function alphanumeric(i)
	local alphanumeric = {"0",
						  "1",
						  "2",
						  "3",
						  "4",
						  "5",
						  "6",
						  "7",
						  "8",
						  "9",
						  "a",
						  "b",
						  "c",
						  "d",
						  "e",
						  "f"}
	
	return alphanumeric[i]
end

function char()
	local characters = {"`",
						"~",
						"!",
						"1",
						"@",
						"2",
						"#",
						"3",
						"$",
						"4",
						"%",
						"5",
						"^",
						"6",
						"&",
						"7",
						"*",
						"8",
						"(",
						"9",
						")",
						"0",
						"_",
						"-",
						"+",
						"=",
						"Q",
						"q",
						"W",
						"w",
						"E",
						"e",
						"R",
						"r",
						"T",
						"t",
						"Y",
						"y",
						"U",
						"u",
						"I",
						"i",
						"O",
						"o",
						"P",
						"p",
						"{",
						"[",
						"}",
						"]",
						"|",
						"\\",
						"A",
						"a",
						"S",
						"s",
						"D",
						"d",
						"F",
						"f",
						"G",
						"g",
						"H",
						"h",
						"J",
						"j",
						"K",
						"k",
						"L",
						"l",
						":",
						";",
						"\"",
						"'",
						"Z",
						"z",
						"X",
						"x",
						"C",
						"c",
						"V",
						"v",
						"B",
						"b",
						"N",
						"n",
						"M",
						"m",
						"<",
						",",
						">",
						"?",
						"/"}
						
	return characters[math.random(#characters)]
end

function hex()
	local hex = ""
	
	for i = 1, 4 do hex = hex .. alphanumeric(math.random(16)) end
	
	return hex
end

function randomchar()
	local chance = math.random(3)
	
	if chance == 2 then return char() else return "." end
end

function counter(i)	
	local count        = ""
	local t            = {}

	t[1] = 0
	t[2] = math.floor(i % 16)
	t[3] = math.floor(i / 16) % 16
	t[4] = math.floor(i / 256) % 16
	t[5] = math.floor(i / 4096) % 16
	t[6] = math.floor(i / 65536) % 16
	t[7] = math.floor(i / 1048576) % 16
	
	for i = 7, 1, -1 do count = count .. alphanumeric(t[i] + 1) end
	
	return count
end


local i = 0
function love.update(dt)
	ta = ta + dt
	
	if ta >= tr then
		text[#text + 1] = counter(i) .. ": "
		for x = 1, 8 do text[#text + 1] = hex() .. " " end
		for x = 1, 16 do text[#text + 1] = randomchar() end
		ta = ta - tr
		i = i + 1
	end
	
end

function love.draw()
	local length = 0
	local vwrap  = 0
	local line   = math.floor(#text / 25)
	
	if line > 50 then vwrap = line - 50 end
	
	love.graphics.translate(120, -vwrap * font:getHeight())
	
	for index, text in ipairs(text) do
		local line  = math.floor(index / 25)
		local x    = length % 520
		local y    = line * font:getHeight()
		local wrap = math.huge
		love.graphics.printf(text, font, x, y, wrap)
		length = length + font:getWidth(text)
	end
end