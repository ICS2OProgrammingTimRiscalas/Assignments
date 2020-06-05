-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOAL VARIABLES
-----------------------------------------------------------------------------------------

-- make the sound effect
bkgSound = audio.loadSound("Sounds/bkg sound.mp3")

-- variable to see whether the bubbles have been blown
blown = false

-- variable that stops the bubbles 
stop = false

-- make the timer 
TimerOn = false

-- variable that is responsible for muting/unmuting the sound 
soundOn = true

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- the local variables for this scene 
local bkg_image
local playButton
local creditsButton
local instructionsButton
local submarine
local bubbles
local randomTime
local muteButton
local unMuteButton

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )
    StopBubbles()
    timer.cancel(MoveSubmarineTimer)
    if (ShowBubblesTimer) then
        timer.cancel(ShowBubblesTimer)   
    end
    composer.gotoScene( "credits_screen", {effect = "fade", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition Function to Instructions Page
local function InstructionsTransition( )
    StopBubbles()
    timer.cancel(MoveSubmarineTimer)
    if (ShowBubblesTimer) then
        timer.cancel(ShowBubblesTimer)   
    end
    composer.gotoScene( "instructions_screen", {effect = "flip", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    timer.cancel(MoveSubmarineTimer)
    timer.cancel(resetTimer)
    timer.cancel(blowTimer)
    timer.cancel(ShowBubblesTimer)
    -- stop the bkg sound 
    audio.stop(bkgSoundChannel)
    -- transition to the level1 screen 
    composer.gotoScene( "level1_screen", {effect = "zoomInOutFadeRotate", time = 1000})
end    

-----------------------------------------------------------------------------------------

local function Mute (touch)
    if (touch.phase == "ended") then 
        -- pause the music
        audio.pause(bkgSoundChannel)
        -- turn the sound variable off 
        soundOn = false
        -- make the muteButton invisible 
        muteButton.isVisible = true
        --make the unmute button visible 
        unMuteButton.isVisible = false
    end
end

-----------------------------------------------------------------------------------------

local function UnMute (touch)
    if (touch.phase == "ended") then 
        -- play the music
        audio.resume(bkgSoundChannel)
        -- turn the sound variable on
        soundOn = true
        -- make the muteButton invisible 
        muteButton.isVisible = false
        --make the unmute button visible 
        unMuteButton.isVisible = true
    end
end

-----------------------------------------------------------------------------------------

local function AddMuteUnMuteListeners()
    muteButton:addEventListener("touch", UnMute)
    unMuteButton:addEventListener("touch", Mute)
end

-----------------------------------------------------------------------------------------

local function RemoveMuteUnMuteListeners()
    muteButton:removeEventListener("touch", UnMute)
    unMuteButton:removeEventListener("touch", Mute)
end

-----------------------------------------------------------------------------------------


-- function that moves the submarine across the screen 
local function MoveSubmarine( event )
    submarine.x = submarine.x + 8
    if (blown == false) then
        bubbles.x = bubbles.x + 8
    end
    if (submarine.x == display.contentWidth) then
        submarine.x = 0
        bubbles.x = submarine.x + 40 
    end
    MoveSubmarineTimer = timer.performWithDelay(30, MoveSubmarine)
end

-----------------------------------------------------------------------------------------

-- functions that stops the bubbles 
function StopBubbles( event )
    if (resetTimer) then
        timer.cancel(resetTimer)
    end
    if (blowTimer) then
        timer.cancel(blowTimer)
    end
    stop = true
    blown = false
    bubbles.isVisible = false
    bubbles.y = display.contentHeight/2.7
    bubbles.x = submarine.x + 40
    TimerOn = false
    setTimer()
end
-----------------------------------------------------------------------------------------

local function StartTimer( )
    resetTimer = timer.performWithDelay(2000, StopBubbles)
end

-----------------------------------------------------------------------------------------

local function BlowBubbles( event )
    bubbles.isVisible = true
    blown = true
    bubbles.y = bubbles.y - 3
    blowTimer = timer.performWithDelay(30, BlowBubbles)
    if (TimerOn == false) then
        TimerOn = true
        StartTimer()
    end
end
-----------------------------------------------------------------------------------------
function setTimer( )
    randomTime = math.random(1000, 2000)
    ShowBubblesTimer = timer.performWithDelay(randomTime, BlowBubbles)
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

   
    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/mainMenu_background.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- display the submarine 
    submarine = display.newImageRect("Images/yellowSubmarine.png",200, 200)
    submarine.x = 0
    submarine.y = display.contentHeight/2
    submarine.width = 200
    submarine.height = 200

    -- display the bubbles
    bubbles = display.newImageRect("Images/bubbles.png",50, 50)
    bubbles.x = submarine.x + 40
    bubbles.y = display.contentHeight/2.7
    bubbles.width = 50
    bubbles.height = 50
    bubbles.isVisible = false

    -- mute button 
    muteButton = display.newImageRect ("Images/Mute Button.png", 70, 70)
    muteButton.x = 980
    muteButton.y = 50
    muteButton.isVisible = false

    -- unmute button 
    unMuteButton = display.newImageRect ("Images/Unmute Button.png", 70, 70)
    unMuteButton.x = 980
    unMuteButton.y = 50
    unMuteButton.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( muteButton )

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( unMuteButton )

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- adding the objects to the scene 
    sceneGroup:insert( submarine )

    -- adding the objects to the scene 
    sceneGroup:insert( bubbles )

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.25/8,
            y = display.contentHeight*7/8,

            -- change the width of the button to be consistent throughout
            width = 250,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Play Button Unpressed.png",
            overFile = "Images/Play Button Pressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6.75/8,
            y = display.contentHeight*7/8,
           
            -- change the width of the button to be consistent throughout
            width = 250,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Credits Button Unpressed.png",
            overFile = "Images/Credits Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 

    
    -----------------------------------------------------------------------------------------

   -- Creating Instructions Button
    instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*7/8,

            -- change the width of the button to be consistent throughout
            width = 250,
            height = 100,

            -- Insert the images here
            defaultFile = "Images/Instructions Button Unpressed.png",
            overFile = "Images/Instructions Button Pressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )

    
    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- see whether to pause or play bkg sound 
    if (soundOn == true) then 
        -- play the bkg music
        bkgSoundChannel = audio.play(bkgSound, {channel = 1, loops = -1})
        muteButton.isVisible = false
        unMuteButton.isVisible = true
    else 
        -- pause the music 
        audio.pause(bkgSoundChannel)
    end

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
        MoveSubmarine()
        setTimer()

    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    -- make function to call bkg music so there is no overlap between scenes 
    elseif ( phase == "did" ) then
        print(soundOn)

        -- add the mute and unmute functionality to the buttons 
        AddMuteUnMuteListeners()

    end
end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view


    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --audio.pause(bkgSound)
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- remove mute and unmute listeners 
        RemoveMuteUnMuteListeners()
        -- Called immediately after scene goes off screen.
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
