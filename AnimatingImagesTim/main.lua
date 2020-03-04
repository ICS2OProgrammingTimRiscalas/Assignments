-----------------------------------------------------------------------------------------
--
-- 
--
-----------------------------------------------------------------------------------------

-- -- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeedMars = 3.5
scrollSpeedAstronaut = 4.0
scrollSpeedRocketShip = 3.8

-- background image with width and height
local backgroundImage = display.newImageRect("Images/background.jfif", 2048, 1536)

-- character image with width and height
local mars = display.newImageRect("Images/mars.png", 200, 200)

-- set the image to be transparent
mars.alpha = 0

-- set the initial x and y position of mars
mars.x = 0
mars.y = display.contentHeight/3

-- Function: MoveMars
-- Input: this funstion accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the ship
local function MoveMars(event)
	-- add the scroll speed to the x-value of the ship
	mars.x = mars.x + scrollSpeedMars
	-- change the transparency of the ship every time it moves so that it fades in
	mars.alpha = mars.alpha + 0.01
end

-- MoveMars will be called over and over again
Runtime:addEventListener("enterFrame", MoveMars)

-- charcter image with width and height
local astronaut = display.newImageRect("Images/astronaut2.png", 300, 300)

-- set the image to be in full colour
astronaut.alpha = 1

-- set the intial x and y position of astronaut
astronaut.x = 1024
astronaut.y = display.contentHeight * 2/3

-- Function: MoveAstronaut
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the astronaut
local function MoveAstronaut(event)
	-- add the scroll speed to the x-value of the ship
	astronaut.x = astronaut.x - scrollSpeedAstronaut
	-- change the transparency of the ship every time it moves so that it fades out
	astronaut.alpha = astronaut.alpha - 0.0001  
	-- make the astronaut grow in size
	astronaut:scale(1.003, 1.003)
end

-- MoveAstronaut will be called over and over again
Runtime:addEventListener("enterFrame", MoveAstronaut)