-----------------------------------------------------------------------------------------
-- Title: Animating Images
-- Course: ICS20
-- Name: Tim Riscalas
-- This program displays three moving images.
-----------------------------------------------------------------------------------------

-- -- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

local backgroundSound = audio.loadSound("Sounds/creepy space sound.mp3")
local backgroundSoundChannel = audio.play(backgroundSound,{loops = -1})

-- global variables
scrollSpeedMoon = 3.5
scrollSpeedAstronaut = 3.75
scrollSpeedRocketShip = 4.2
parabolicCurve = 0.1

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
	parabolicCurve = parabolicCurve + 0.001
	-- make the moon travel on a parabolic curve
	moon.y = moon.x * parabolicCurve
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
	if (astronaut.x >= 1024) or (Hitwall1 == true) then
		astronaut.x = astronaut.x - scrollSpeedAstronaut
		-- change the transparency of the ship every time it moves so that it fades out
		astronaut.alpha = astronaut.alpha - 0.001  
		-- make the astronaut grow in size and turn back when it hits the far wall
		astronaut.width = astronaut.width + 1
		astronaut.height = astronaut.height + 1
		if (astronaut.alpha <= 0.132) then
			Hitwall1 = false
		else
			Hitwall1 = true
		end
	else
		-- change the transparency of the ship every time it moves so that it fades out
		astronaut.alpha = astronaut.alpha + 0.01  
		-- make the astronaut grow in size
		astronaut.width = astronaut.width - 1
		astronaut.height = astronaut.height - 1
		astronaut.x = astronaut.x + scrollSpeedAstronaut
	end

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
	rocketShip.y = rocketShip.y - scrollSpeedRocketShip
	-- change the transparency of the ship every time it moves so that it fades in
	rocketShip.alpha = rocketShip.alpha + 0.01 
	-- make the rocketShip grow in size
	rocketShip:scale(1.003, 1.003)
	if (rocketShip.x <= 0) then
		Runtime:removeEventListener("enterFrame", MoveRocketShip)
	end
	
end

-- MoveRocketShip will be called over and over again
Runtime:addEventListener("enterFrame", MoveRocketShip)