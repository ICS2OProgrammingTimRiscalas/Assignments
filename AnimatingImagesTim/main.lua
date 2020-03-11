-----------------------------------------------------------------------------------------
-- Title: Animating Images
-- Course: ICS20
-- Name: Tim Riscalas
-- This program displays three moving images.
-----------------------------------------------------------------------------------------

 -- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- background image with width and height
backgroundImage = display.newImageRect("Images/background.jfif", 2048, 1536)

---------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
---------------------------------------------------------------------------------------------
local backgroundSound
local backgroundSoundChannel
local rocketShip
local moon
local astronaut
local backgroundImage
local title 

---------------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
---------------------------------------------------------------------------------------------

scrollSpeedMoon = 3.5
scrollSpeedAstronaut = 4.0
scrollSpeedRocketShip = 3.8
parabolicCurve = 0.1

---------------------------------------------------------------------------------------------
-- SOUND
---------------------------------------------------------------------------------------------

-- make a background sound
backgroundSound = audio.loadSound("Sounds/creepy space sound.mp3")
backgroundSoundChannel = audio.play(backgroundSound,{loops = -1})

----------------------------------------------------------------------------------------------
-- TEXT CREATION
----------------------------------------------------------------------------------------------

-- add text to the program
title = display.newText("Creepy Galaxies", display.contentWidth/2, display.contentHeight/2, nil, 100)
title:setTextColor(219/255, 4/255, 4/255)

---------------------------------------------------------------------------------------------
-- MOON CREATION
---------------------------------------------------------------------------------------------

-- character image (moon) with width and height
moon = display.newImageRect("Images/moon.png", 200, 200)

-- set the image to be transparent
moon.alpha = 0

-- set the initial x and y position of moon
moon.x = 0
moon.y = display.contentHeight/3

---------------------------------------------------------------------------------------------
-- ROCKETSHIP CREATION
---------------------------------------------------------------------------------------------

-- charcter image with width and height
rocketShip = display.newImageRect("Images/rocketship.png", 300, 300)

-- set the image to be in full colour
rocketShip.alpha = 1

-- set the intial x and y position of rocketShip
rocketShip.x = 1024
rocketShip.y = display.contentHeight/1

---------------------------------------------------------------------------------------------
-- ASTRONAUT CREATION
---------------------------------------------------------------------------------------------

-- charcter image (astronaut) with width and height
astronaut = display.newImageRect("Images/astronaut.png", 300, 300)

-- set the image to be in full colour
astronaut.alpha = 1

-- set the intial x and y position of astronaut
astronaut.x = 1024
astronaut.y = display.contentHeight * 2/3

----------------------------------------------------------------------------------------------
-- LOCAL MOON FUNCTION
----------------------------------------------------------------------------------------------

-- Function: MoveMoon
-- Input: this funstion accepts an event listener
-- Output: none
-- Description: This function makes the moon move in a parabolic path
local function MoveMoon(event)
	-- add the scroll speed to the x-value of the ship
	moon.x = moon.x + scrollSpeedMoon
	-- make the moon travel on a parabolic curve
	parabolicCurve = parabolicCurve + 0.001
	moon.y = moon.x * parabolicCurve
	-- change the transparency of the ship every time it moves so that it fades in
	moon.alpha = moon.alpha + 0.01
end

-- MoveMoon will be called over and over again
Runtime:addEventListener("enterFrame", MoveMoon)

-- make the moon rotate
local function RotateMoon(event)
	moon:rotate(10)
end

-- RotateMoon will be called over and over again
Runtime:addEventListener("enterFrame", RotateMoon)

----------------------------------------------------------------------------------------------
-- LOCAL ASTRONAUT FUNCTION
------------------------------------------------------------------------------------------------ 

-- Function: MoveAstronaut
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the x-value of the astronaut and makes it 'bounce off the walls'
local function MoveAstronaut(event)
	-- make the astronaut move and bounce off the walls
	if (astronaut.x >= 1024) or (hitWall1 == true) then
		astronaut.x = astronaut.x - scrollSpeedAstronaut
		-- change the transparency of the ship every time it moves so that it fades out
		astronaut.alpha = astronaut.alpha - 0.0001  
		-- make the astronaut grow in size and 
		astronaut.width = astronaut.width + 1
		astronaut.height = astronaut.height + 1
		if (astronaut.alpha <=0.132) then
			hitWall1 = false
		else
			hitWall1 = true
		end
	else
		-- make the astronaut bounce back off the wall 
		astronaut.x = astronaut.x + scrollSpeedAstronaut

		-- change the transparency of the astronaut so it fades in the first time it hits the wall
		astronaut.alpha = astronaut.alpha + 0.01
		-- make the astronaut shrink in size
		astronaut.width = astronaut.width - 1
		astronaut.height = astronaut.height - 1
	end
end

-- MoveAstronaut will be called over and over again
Runtime:addEventListener("enterFrame", MoveAstronaut)

----------------------------------------------------------------------------------------------
-- LOCAL ROCKETSHIP FUNCTION
----------------------------------------------------------------------------------------------

-- Function: MoveRocketShip
-- Input: this function accepts an event listener
-- Output: none
-- Description: This function adds the scroll speed to the
	-- add the scroll speed to the x-value of the ship x-value of the rocketShip
local function MoveRocketShip(event)
	rocketShip.x = rocketShip.x - scrollSpeedRocketShip
	rocketShip.y = rocketShip.y - scrollSpeedRocketShip

	-- change the transparency of the ship every time it moves so that it fades out
	rocketShip.alpha = rocketShip.alpha - 0.0001  
	-- make the rocketShip grow in size
	rocketShip:scale(1.003, 1.003)
	-- make the rocketship stop growing when it moves off the screen 
	if (rocketShip.x <= 0) then
		Runtime:removeEventListener("enterFrame", MoveRocketShip)
	end
end

-- MoveRocketShip will be called over and over again
Runtime:addEventListener("enterFrame", MoveRocketShip)

