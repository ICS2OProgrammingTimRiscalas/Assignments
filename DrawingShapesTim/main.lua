-----------------------------------------------------------------------------------------
-- Tim Riscalas
-- ICS20/3C
-- This program displays four shapes on the iPad, with borders for each shape. The area of the triangle is also calculated with a gradient fill for the hexagon.
-----------------------------------------------------------------------------------------

-- Your code here

local myTriangle
local verticesOfTriangle = {-100, -100, 0, 100, 80, -100}
local areaOfTriangle
local heightOfTriangle
local baseOfTriangle
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