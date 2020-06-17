-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_screen"
Hearts = 3
-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image
local submarine
local heart1
local heart2
local heart3
local spike1  
local spike2
local spike3
local spike4
local dragon
local stopImage = 0

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- function that goes to you win screen 
local function gotoYouWin( )
    -- stop the music 
    audio.stop()
    composer.gotoScene("YouWin_screen")
end

-- function that goes to you lose screen 
local function gotoYouLose( )
    --cancel the timer 
    -- stop the music 
    audio.stop()
    composer.gotoScene("YouLose_screen")
end

local function Level2Question()
    -- hide the dragonVisibleText
    dragonVisibleText.isVisible = false
    -- go to Level2Question
    composer.showOverlay("level2_question")
end

-- function that hides the heartloss text
local function HideText( )
    heartLossText.isVisible = false
end

local function Dragon()
    -- if dragon is visible, show dragon visible text 
    dragonVisibleText.isVisible = true 
    -- wait then call level2 question 
    timer.performWithDelay(3000, Level2Question)
end

-- function that allows the submarine to move up 
local function MoveUp( touch )
    if (((submarine.y - submarine.height) < bkg_imageBorder1.y ) and 
    ((submarine.y + submarine.height) > bkg_imageBorder1.y ) ) then


    else
        submarine.y = submarine.y - 1
    end
end

-- function that allows the submarine to move down 
local function MoveDown( touch )
    if (((submarine.y - submarine.height/1.2) < bkg_imageBorder2.y ) and 
    ((submarine.y + submarine.height/1.2) > bkg_imageBorder2.y ) ) then

    else
        submarine.y = submarine.y + 1
    end
end

-- function that allows the submarine to move left 
local function MoveLeft( touch )
    if ( submarine.x >= display.contentWidth/10 ) then
        submarine.x = submarine.x - 1
    elseif (stopImage > 0) then
        print(stopImage)
        stopImage = stopImage - 1
        bkg_imageBorder1.x = bkg_imageBorder1.x + 1
        bkg_imageBorder2.x = bkg_imageBorder2.x + 1
        bkg_image.x = bkg_image.x + 1
        spike2.x = spike2.x + 1
        spike1.x = spike1.x +1
    end
end

-- function that allows the submarine to move right 
local function MoveRight( touch )
    if (submarine.x <= display.contentWidth/2) or (stopImage >= 3000) then
        if (stopImage < 3000) then
            submarine.x = submarine.x + 1
        end
    elseif (stopImage < 3000) then
        print(stopImage)
        stopImage = stopImage + 1
        bkg_image.x = bkg_image.x - 1
        bkg_imageBorder1.x = bkg_imageBorder1.x - 1
        bkg_imageBorder2.x = bkg_imageBorder2.x - 1
        spike1.x = spike1.x - 1
        spike2.x = spike2.x - 1
        if (stopImage >= 600) then
            spike3.isVisible = true
            spike3.x = spike3.x - 1
        end
        if (stopImage >= 900) then
            spike4.isVisible = true
            spike4.x = spike4.x - 1
        end
    end
    if (stopImage >= 3000) and (answeredQuestions == true) then
        dragon.alpha = dragon.alpha - 0.01
        
    elseif (stopImage >= 3000) and (dragon.alpha < 1) then
        dragon.alpha = dragon.alpha + 0.01
        timer.performWithDelay(100, MoveRight)
    end

    if (dragon.alpha >= 1) then
        -- call the dragon function 
        timer.performWithDelay(500, Dragon)
    end

    if (stopImage >= 1024) then
        stopImage = stopImage + 1
    end
end
local function CheckIfHit(  )
    if (((spike1.x - spike1.width/3) < submarine.x ) and
    ((spike1.x + spike1.width/3) > submarine.x ) and 
    ((spike1.y - spike1.height) < submarine.y ) and 
    ((spike1.y + spike1.height) > submarine.y ) ) or 
    (((submarine.x - submarine.width/3) < spike2.x ) and
    ((submarine.x + submarine.width/3) > spike2.x ) and 
    ((submarine.y - submarine.height) < spike2.y ) and 
    ((submarine.y + submarine.height) > spike2.y ) ) or 
    (((submarine.x - submarine.width/3) < spike3.x ) and
    ((submarine.x + submarine.width/3) > spike3.x ) and 
    ((submarine.y - submarine.height) < spike3.y ) and 
    ((submarine.y + submarine.height) > spike3.y ) ) or 
    (((submarine.x - submarine.width/3) < spike4.x ) and
    ((submarine.x + submarine.width/3) > spike4.x ) and 
    ((submarine.y - submarine.height) < spike4.y ) and 
    ((submarine.y + submarine.height) > spike4.y ) ) then
        print( "***HIT***" )
        submarine.x = display.contentWidth/10
        submarine.y = display.contentHeight/2
        bkg_image.x = display.contentCenterX
        bkg_image.y = display.contentCenterY
        bkg_image.width = display.contentWidth*11/3
        bkg_image.height = display.contentHeight/1.5
        bkg_imageBorder1.anchorX = 0
        bkg_imageBorder1.anchorX = 0
        bkg_imageBorder1.x = 0
        bkg_imageBorder1.y = display.contentHeight/23
        bkg_imageBorder1.width = display.contentWidth*11/3
        bkg_imageBorder1.height = display.contentHeight/4
        bkg_imageBorder2.x = 0
        bkg_imageBorder2.y = display.contentHeight/1.09
        bkg_imageBorder2.width = display.contentWidth*15/3
        bkg_imageBorder2.height = display.contentHeight/6
        stopImage = 0
        spike1.x = display.contentWidth/2
        spike1.y = display.contentHeight/4
        spike2.x = display.contentWidth/1.2
        spike2.y = display.contentHeight/1.25
        spike4.x = display.contentWidth*1.1
        spike4.y = display.contentHeight/1.25 
        spike4.isVisible = false
        spike3.x = display.contentWidth*1.1
        spike3.y = display.contentHeight/4 
        spike3.isVisible = false
        -- function that chacks how many hearts should be displayed
        if (Hearts == 3) then 
            heart3.isVisible = false
            Hearts = Hearts - 1
            heartLossText.isVisible = true 
            timer.performWithDelay(2000, HideText)
        elseif (Hearts == 2) then 
            heart2.isVisible = false
            Hearts = Hearts - 1
            heartLossText.isVisible = true 
            timer.performWithDelay(2000, HideText)
        elseif (Hearts == 1) then 
            heart1.isVisible = false 
            Hearts = Hearts - 1
            heartLossText.isVisible = true 
            timer.performWithDelay(2000, HideText)
        end
    end
   --timer.performWithDelay(10, CheckIfHit)
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Insert the background image
    bkg_image = display.newImageRect("Images/tunnel.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth*15/3
    bkg_image.height = display.contentHeight/1.5

    bkg_imageBorder1 = display.newImageRect("Images/tunnelborder1.png", display.contentWidth, display.contentHeight)
    bkg_imageBorder1.anchorX = 0
    bkg_imageBorder1.anchorX = 0
    bkg_imageBorder1.x = 0
    bkg_imageBorder1.y = display.contentHeight/23
    bkg_imageBorder1.width = display.contentWidth*15/3
    bkg_imageBorder1.height = display.contentHeight/4


    bkg_imageBorder2 = display.newImageRect("Images/tunnelborder2.png", display.contentWidth, display.contentHeight)
    bkg_imageBorder2.x = 0
    bkg_imageBorder2.y = display.contentHeight/1.09
    bkg_imageBorder2.width = display.contentWidth*18/3
    bkg_imageBorder2.height = display.contentHeight/6
    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()  
    bkg_imageBorder1:toBack()

    -- make the submarine
    submarine = display.newImage("Images/yellowSubmarine.png", 200, 200)
    submarine.x = display.contentWidth/10
    submarine.y = display.contentHeight/2
    -- make the down arrow 
    downArrow = display.newImageRect("Images/DownArrow.png", 100, 100)
    downArrow.x = display.contentWidth/1.05
    downArrow.y = display.contentHeight/1.07

    -- make the up arrow 
    upArrow = display.newImageRect("Images/UpArrow.png", 100, 100)
    upArrow.x = display.contentWidth/1.05
    upArrow.y = display.contentHeight/1.26

    -- make the left arrow 
    leftArrow = display.newImageRect("Images/LeftArrow.png", 100, 100)
    leftArrow.x = display.contentWidth/20
    leftArrow.y = display.contentHeight/1.07

    -- make the right arrow 
    rightArrow = display.newImageRect("Images/RightArrow.png", 100, 100)
    rightArrow.x = display.contentWidth/6
    rightArrow.y = display.contentHeight/1.07

    -- make heart1
    heart1 = display.newImageRect("Images/heart.png", 100, 100)
    heart1.x = display.contentWidth/1.1
    heart1.y = display.contentHeight/15
    heart1.isVisible = false

    -- make heart2
    heart2 = display.newImageRect("Images/heart.png", 100, 100)
    heart2.x = display.contentWidth/1.25
    heart2.y = display.contentHeight/15
    heart2.isVisible = false

    -- make heart3 
    heart3 = display.newImageRect("Images/heart.png", 100, 100)
    heart3.x = display.contentWidth/1.45
    heart3.y = display.contentHeight/15
    heart3.isVisible = false

    -- make the HeartLossText for when the user loses a life 
    heartLossText = display.newText("AVOID THE SPIKES!\n" .. 
        "You lost a life", display.contentWidth/1.5, display.contentHeight/2, nil, 50)
    heartLossText.isVisible = false

    -- make the spike1 
    spike1 = display.newImageRect("Images/spike1.png", 200, 200)
    spike1.x = display.contentWidth/2
    spike1.y = display.contentHeight/4

    -- make spike2
    spike2 = display.newImageRect("Images/spike2.png", 200, 200)
    spike2.x = display.contentWidth/1.2
    spike2.y = display.contentHeight/1.25

    -- make spike3
    spike4 = display.newImageRect("Images/spike2.png", 200, 200)
    spike4.x = display.contentWidth*1.1
    spike4.y = display.contentHeight/1.25 
    spike4.isVisible = false

    spike3 = display.newImageRect("Images/spike1.png", 200, 200)
    spike3.x = display.contentWidth*1.1
    spike3.y = display.contentHeight/4 
    spike3.isVisible = false

    dragon = display.newImageRect("Images/dragon.png", 200, 200)
    dragon.x = display.contentWidth/1.5
    dragon.y = display.contentCenterY
    dragon.height = display.contentHeight
    dragon.width = display.contentWidth/1.5
    dragon.alpha = 0

    dragonVisibleText = display.newText("To save your friend,\n" .. 
        "you must answer these three questions", display.contentWidth/2.8, display.contentHeight/9, nil, 40)
    dragonVisibleText.isVisible = false

    -- add the objects to tho scenegroup 
    sceneGroup:insert( bkg_image )
    
    sceneGroup:insert( heartLossText )
    sceneGroup:insert( spike1 )
    sceneGroup:insert( spike2 )
    sceneGroup:insert( spike3 )
    sceneGroup:insert( spike4 )
    sceneGroup:insert( bkg_imageBorder1 )
    sceneGroup:insert( bkg_imageBorder2 )
    sceneGroup:insert( submarine )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( downArrow )
    sceneGroup:insert( upArrow )
    sceneGroup:insert( leftArrow )
    sceneGroup:insert( rightArrow )
    sceneGroup:insert( dragon )
    sceneGroup:insert( dragonVisibleText )
end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
    -- function that chacks how many hearts should be displayed
    if (Hearts == 3) then 
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = true
    elseif (Hearts == 2) then 
        heart1.isVisible = true
        heart2.isVisible = true
        heart3.isVisible = false
    elseif (Hearts == 1) then 
        heart1.isVisible = true
        heart2.isVisible = false 
        heart3.isVisible = false 
    else 
        heart1.isVisible = false
        heart2.isVisible = false 
        heart3.isVisible = false  
    end
    elseif ( phase == "did" ) then
        leftArrow:addEventListener("touch", MoveLeft)
        rightArrow:addEventListener("touch", MoveRight)
        upArrow:addEventListener("touch", MoveUp)
        downArrow:addEventListener("touch", MoveDown)
        CheckIfHit()
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
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
