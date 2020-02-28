-----------------------------------------------------------------------------------------
-- Tim Riscalas
-- ICS20
-- This program displays four shapes on the iPad, with borders for each shape. The area of the triangle is also calculated with a gradient fill for the hexagon.
-----------------------------------------------------------------------------------------

-- Your code here

local myTriangle
local verticesOfTriangle = {-100, -100, 0, 100, 80, -100}
local areaOfTriangle
local heightOfTriangle = 9
local baseOfTriangle = 6
local areaOfTriangle

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- set the background colour
display.setDefault("background", 98/255, 98/255, 98/255)

-- display the triangle
myTriangle = display.newPolygon(display.contentWidth/5, display.contentHeight/4, verticesOfTriangle)

-- flip the triangle
myTriangle:scale(1, -1)

-- set the colour of the triangle
myTriangle:setFillColor(38/255, 69/255, 226/255)

-- set the width of the border
myTriangle.strokeWidth = 15

-- set the color of the border
myTriangle:setStrokeColor(203/255, 64/255, 43/255)

-- calculate the area of the triangle
areaOfTriangle = baseOfTriangle * heightOfTriangle / 2

-- write the area on the screen.
areaText = display.newText("The area of this triangle with a base of \n" .. 
	baseOfTriangle .. " and a height " .. heightOfTriangle .. " is ".. 
	areaOfTriangle .. " pixels².", 0, 0, Caveat, 25)

-- anchor the text and set its (x,y) position
areaText.anchorX = 0
areaText.anchorY = 0
areaText.x = display.contentWidth/9
areaText.y = display.contentHeight/2.3

-- set the color of the text
areaText:setTextColor(204/255, 64/255, 43/255)