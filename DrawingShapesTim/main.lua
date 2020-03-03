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
local areaTextTriangle
local myHexagon
local verticesOfHexagon = {0,0, 4,6, 6,0, -8,-6, -10,-4, -6,4}
local areaTextHexagon

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- set the background colour
display.setDefault("background", 98/255, 98/255, 98/255)

-- display the triangle
myTriangle = display.newPolygon(display.contentWidth/5, display.contentHeight/4, verticesOfTriangle)

-- flip the triangle
myTriangle:scale(1, -1)

-- set the colour of the triangle
local paint =  {
	type = "gradient",
	color1 = { 38/255, 69/255, 226/225 },
	color2 = { 255/255, 255/255, 255/255 },
	directions = "up"
 }
myTriangle.fill = paint

-- set the width of the border
myTriangle.strokeWidth = 15

-- set the color of the border
myTriangle:setStrokeColor(0/255, 0/255, 0/255)

-- calculate the area of the triangle
areaOfTriangle = baseOfTriangle * heightOfTriangle / 2

-- write the area on the screen.
areaTextTriangle = display.newText("The area of this triangle with a base of \n" .. 
	baseOfTriangle .. " and a height " .. heightOfTriangle .. " is ".. 
	areaOfTriangle .. " pixels².", 0, 0, Caveat, 25)

-- anchor the text and set its (x,y) position
areaTextTriangle.anchorX = 0
areaTextTriangle.anchorY = 0
areaTextTriangle.x = display.contentWidth/9
areaTextTriangle.y = display.contentHeight/2.3

-- set the color of the text
areaTextTriangle:setTextColor(255/255, 255/255, 255/255)

-- display the hexagon
myHexagon = display.newPolygon(display.contentWidth/1.5, display.contentHeight/4, verticesOfHexagon)

-- set the colour of the hexagon
local paint =  {
	type = "gradient",
	color1 = { 44/255, 191/255, 49/225 },
	color2 = { 255/255, 255/255, 255/255 },
	directions = "up"
 }
myHexagon.fill = paint

-- set the size of my Hexagon
myHexagon:scale(15, 15)

-- flip the hexagon
myHexagon:scale(1, -1)

-- set the width of the border
myHexagon.strokeWidth = 1

-- set the color of the border
myHexagon:setStrokeColor(0/255, 0/255, 0/255)

-- write "hexagon" on the screen 
areaTextHexagon = display.newText("hexagon", 0, 0, Caveat, 25)

-- anchor the text and set its (x,y) position
areaTextHexagon.anchorX = 0
areaTextHexagon.anchorY = 0
areaTextHexagon.x = display.contentWidth/1.7
areaTextHexagon.y = display.contentHeight/4.1

-- set the colour of the text
areaTextHexagon:setTextColor(0/255, 0/255, 0/255)
