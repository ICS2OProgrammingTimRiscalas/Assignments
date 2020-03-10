-----------------------------------------------------------------------------------------
-- Title: Animating Images
-- Course: ICS20
-- Name: Tim Riscalas
-- This program displays three moving images.
-----------------------------------------------------------------------------------------

-- -- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- global variables
scrollSpeedMoon = 3.5
scrollSpeedAstronaut = 4.0
scrollSpeedRocketShip = 3.8

-- background image with width and height
local backgroundImage = display.newImageRect("Images/background.jfif", 2048, 1536)

-- character image with width and height
local moon = display.newImageRect("Images/moon.png", 200, 200)

-- set the image to be transparent
moon.alpha = 0

-- set the initial x and y position of moon
moon.x = 0
moon.y = display.contentHeight/3

-- Function: MoveMoon
-- Input: this funstion accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the ship
local function MoveMoon(event)
	-- add the scroll speed to the x-value of the ship
	moon.x = moon.x + scrollSpeedMoon
	-- change the transparency of the ship every time it moves so that it fades in
	moon.alpha = moon.alpha + 0.01
end

-- MoveMoon will be called over and over again
Runtime:addEventListener("enterFrame", MoveMoon)

-- charcter image with width and height
local astronaut = display.newImageRect("Images/astronaut.png", 300, 300)

-- set the image to be in full colour
astronaut.alpha = 1

-- set the intial x and y position of astronaut
astronaut.x = 1024
astronaut.y = display.contentHeight * 1/1.3

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
	astronaut:scale(1.002, 1.002)
end

-- MoveAstronaut will be called over and over again
Runtime:addEventListener("enterFrame", MoveAstronaut)

-- charcter image with width and height
local rocketShip = display.newImageRect("Images/rocketship.png", 300, 300)

-- set the image to be in full colour
rocketShip.alpha = 0

-- set the intial x and y position of rocketShip
rocketShip.x = 1024
rocketShip.y = display.contentHeight/1

-- Function: MoveRocketShip
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the rocketShip
local function MoveRocketShip(event)
	-- add the scroll speed to the x-value of the ship
	rocketShip.x = rocketShip.x - scrollSpeedRocketShip
	-- change the transparency of the ship every time it moves so that it fades in
	rocketShip.alpha = rocketShip.alpha + 0.01 
	-- make the rocketShip grow in size
	rocketShip:scale(1.003, 1.003)
	rocketShip:scale(1,1)
end

-- MoveRocketShip will be called over and over again
Runtime:addEventListener("enterFrame", MoveRocketShip)