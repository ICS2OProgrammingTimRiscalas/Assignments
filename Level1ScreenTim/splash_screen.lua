-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Tim R 
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that I created in photoshop.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

-- hide the status bar 
display.setStatusBar(display.HiddenStatusBar)

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local spookySounds = audio.loadSound("Sounds/spooky sounds.ogg", {channel = 1})
local spookySoundsChannel
----------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local background
local submarine1
local submarine2
local completeSubmarine
local spiderSubmarine
local spiderWeb
local scrollXSpeed = 8
local scrollYSpeed = -8
local spinCounter = 0
local spinTimer
local spiderTimer1
local timer1Off = false

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- Creating Transition Function to Main Menu Screen 
local function MainMenuTransition( )       
    composer.gotoScene( "main_menu", {effect = "zoomInOutFade", time = 500})
end 

local function SpiderFadeIn( )
    if (spiderSubmarine.width < 1000) then
        completeSubmarine.alpha = completeSubmarine.alpha - 0.1
        spiderSubmarine.alpha = spiderSubmarine.alpha + 0.1
        completeSubmarine.width = completeSubmarine.width - 50
        spiderSubmarine.width = spiderSubmarine.width + 50
        completeSubmarine.height = completeSubmarine.height - 50
        spiderSubmarine.height = spiderSubmarine.height + 25
        spiderWeb.height = spiderWeb.height - 5
        timer.performWithDelay(100, SpiderFadeIn)
    else
        timer.performWithDelay(100, MainMenuTransition)
    end
end

-- making the submarine move up and down the spiderWeb
local function SpiderSubmarineDown( )
    completeSubmarine.y = completeSubmarine.y - scrollYSpeed
    spiderWeb.y = spiderWeb.y - scrollYSpeed
    if (timer1Off == true) then
        timer.performWithDelay(100, SpiderSubmarineDown)
        if (completeSubmarine.y >= display.contentHeight/2.25) then
            timer1Off = false
            spiderSubmarine.isVisible = true
            spiderSubmarine.alpha = 0
            SpiderFadeIn()
        end
    end
end

-- causing the spider submarine to fade in and grow
local function StartSpiderSubmarine( )
    spiderWeb.isVisible = true
    if (completeSubmarine.y >= display.contentHeight/3.5) then
        completeSubmarine.y = completeSubmarine.y + scrollYSpeed
        spiderWeb.y = spiderWeb.y + scrollYSpeed
        if (timer1Off == false) then
            spiderTimer1 = timer.performWithDelay(100, StartSpiderSubmarine)
        end 
    elseif (completeSubmarine.y <= display.contentHeight/2.25) then
        timer1Off = true
        completeSubmarine.y = completeSubmarine.y + 5
        spiderWeb.y = spiderWeb.y + 5
        SpiderSubmarineDown()
    end
end

-- rotate the submarine 
local function MoveCompleteSubmarine( )
    completeSubmarine:rotate(scrollYSpeed)
    if (spinCounter == 39) then
        timer.cancel(spinTimer)
        timer.performWithDelay(400, StartSpiderSubmarine)
    else
        spinCounter = spinCounter + 1
        spinTimer = timer.performWithDelay(85, MoveCompleteSubmarine)
    end
end

-- The function that moves the submarine1 across the screen
local function MoveSubmarine1()
    submarine1.x = submarine1.x + scrollXSpeed
    submarine1.y = submarine1.y + scrollYSpeed
    -- move the submarine1 towards the centre where it connects to submarine2 
    if (((submarine1.x - completeSubmarine.width/3.7) < completeSubmarine.x ) and 
        ((submarine1.x + completeSubmarine.width/3.7) > completeSubmarine.x ) and 
        ((submarine1.y - completeSubmarine.height/3.7) < completeSubmarine.y ) and 
        ((submarine1.y + completeSubmarine.height/3.7) > completeSubmarine.y ) ) then
        submarine1.isVisible = false
        completeSubmarine.isVisible = true
    end
end


-- The function that moves the submarine2 across the screen
local function MoveSubmarine2()
    submarine2.x = submarine2.x - scrollXSpeed
    submarine2.y = submarine2.y + scrollYSpeed
    -- moves the submarine2 towards the centre where it connects to submarine1
    if (((submarine2.x - completeSubmarine.width/3.7) < completeSubmarine.x ) and 
        ((submarine2.x + completeSubmarine.width/3.7) > completeSubmarine.x ) and 
        ((submarine2.y - completeSubmarine.height/3.7) < completeSubmarine.y ) and 
        ((submarine2.y + completeSubmarine.height/3.7) > completeSubmarine.y ) ) then
        submarine2.isVisible = false
        MoveCompleteSubmarine()
    end
end




-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- display the background image 
    background = display.newImageRect("Images/splash screen background.png", display.contentWidth, display.contentHeight)
    -- anchor the background's position
    background.anchorX = 0
    background.anchorY = 0

    -- Insert the submarine1 image
    submarine1 = display.newImageRect("Images/Submarine 1.png", 200, 200)
    -- set the initial x and y position of the submarine1
    submarine1.x = 0
    submarine1.y = display.contentHeight

    -- Insert the submarine2 image
    submarine2 = display.newImageRect("Images/Submarine 2.png", 200, 200)
    -- set the initial x and y position of the submarine1
    submarine2.x = display.contentWidth
    submarine2.y = display.contentHeight

    -- Insert the completeSubmarine image 
    completeSubmarine = display.newImageRect("Images/Complete submarine.png", 300, 200)
    -- set the initial x and y position of the completeSubmarine
    completeSubmarine.x = display.contentWidth/2
    completeSubmarine.y = display.contentHeight/2.25
    -- make the completeSubmarine invisible
    completeSubmarine.isVisible = false

    -- create the spiderWeb
    spiderWeb = display.newRect(display.contentWidth/2, 0, 5, display.contentHeight/1.5)
    -- make the spiderWeb invisible
    spiderWeb.isVisible = false

    -- display the spiderSubmarine 
    spiderSubmarine = display.newImageRect("Images/Spider submarine.png", 500, 200)
    -- set the initial x and y position of the spiderSubmarine
    spiderSubmarine.x = display.contentWidth/2.08
    spiderSubmarine.y = display.contentHeight/2.59
    -- make the spiderSubmarine invisible
    spiderSubmarine.isVisible = false

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(background)

    sceneGroup:insert( submarine1 )

    sceneGroup:insert( submarine2 )
    
    sceneGroup:insert( spiderWeb )
    
    sceneGroup:insert( spiderSubmarine )


end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        spookySoundsChannel = audio.play(spookySounds )

        -- Call the movesubmarine1 function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveSubmarine1)

        -- Call the movesubmarine function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveSubmarine2)      
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(spookySoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
