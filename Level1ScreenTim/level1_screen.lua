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
sceneName = "level1_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
Dropped = true
Hearts = 3
-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image
local submarine
local heart1
local heart2
local heart3
local musicNote1
local musicNote2
local musicNote3
local musicNote4
local musicNote5
local choseRandomNote
local HeartLossText
local musicNote1Timer
local musicNote2Timer
local musicNote3Timer
local musicNote4Timer
local musicNote5Timer
local StopImage = 0
local Cave

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
--local function gotolevel2( )
    -- cancel the timers 
--    timer.cancel(DropTimer)
--    composer.gotoScene("level2_screen")    
-- end

-- function that goes to you win screen 
local function gotoYouWin( )
    timer.cancel(DropTimer)
    composer.gotoScene("YouWin_screen")
end

-- function that goes to you lose screen 
local function gotoYouLose( )
    --cancel the timer 
    timer.cancel(DropTimer)
    composer.gotoScene("YouLose_screen")
end

-- function that allows the submarine to move left 
local function MoveLeft( touch )
    if ( submarine.x >= display.contentWidth/10 ) then
        submarine.x = submarine.x - 1
    elseif (StopImage > 0) then
        StopImage = StopImage - 1
        bkg_image.x = bkg_image.x + 1
        musicNote1.x = musicNote1.x + 0.5
        musicNote2.x = musicNote2.x + 0.5
        musicNote3.x = musicNote3.x + 0.5
        musicNote4.x = musicNote4.x + 0.5
        musicNote5.x = musicNote5.x + 0.5
    end
end

-- function that allows the submarine to move right 
local function MoveRight( touch )
    if (submarine.x <= display.contentWidth*2/3) or (StopImage >= 1024) then
        submarine.x = submarine.x + 1
    elseif (StopImage < 1024) then
        print(StopImage)
        StopImage = StopImage + 1
        bkg_image.x = bkg_image.x - 1
        musicNote1.x = musicNote1.x - 1
        musicNote2.x = musicNote2.x - 1
        musicNote3.x = musicNote3.x - 1
        musicNote4.x = musicNote4.x - 1
        musicNote5.x = musicNote5.x - 1
    end
    if (StopImage >= 1024) then
        StopImage = StopImage + 1
        Cave.alpha = Cave.alpha + 0.05
    end
    if (StopImage >= 1040) then
        submarine.width = submarine.width - 1
        submarine.height = submarine.height - 1
        submarine.alpha = submarine.alpha - 0.01
        if (submarine.alpha <= 0) then
            print("DONE")
            -- gotolevel2()
            gotoYouWin()
        end
    end
end

-- function that allows the submarine to move up 
local function MoveUp( touch )
    if (submarine.y >= display.contentHeight/7.8) then
        submarine.y = submarine.y - 1
    end
end

-- function that allows the submarine to move down 
local function MoveDown( touch )
    if (submarine.y <= display.contentHeight/1.16) then
        submarine.y = submarine.y + 1
    end
end

-- function that hides the heartloss text
local function HideText(  )
    HeartLossText.isVisible = false
end

-- function that checks if the submarine had been hit by one of the music notes 
local function CheckIfHit( )
    if (((submarine.x - submarine.width/2) < musicNote1.x ) and
    ((submarine.x + submarine.width/2) > musicNote1.x ) and 
    ((submarine.y - submarine.height/2) < musicNote1.y ) and 
    ((submarine.y + submarine.height/2) > musicNote1.y ) ) or 
    (((submarine.x - submarine.width/2) < musicNote2.x ) and
    ((submarine.x + submarine.width/2) > musicNote2.x ) and 
    ((submarine.y - submarine.height/2) < musicNote2.y ) and 
    ((submarine.y + submarine.height/2) > musicNote2.y ) ) or 
    (((submarine.x - submarine.width/2) < musicNote3.x ) and
    ((submarine.x + submarine.width/2) > musicNote3.x ) and 
    ((submarine.y - submarine.height/2) < musicNote3.y ) and 
    ((submarine.y + submarine.height/2) > musicNote3.y ) ) or 
    (((submarine.x - submarine.width/2) < musicNote4.x ) and
    ((submarine.x + submarine.width/2) > musicNote4.x ) and 
    ((submarine.y - submarine.height/2) < musicNote4.y ) and 
    ((submarine.y + submarine.height/2) > musicNote4.y ) ) or
    (((submarine.x - submarine.width/2) < musicNote5.x ) and
    ((submarine.x + submarine.width/2) > musicNote5.x ) and 
    ((submarine.y - submarine.height/2) < musicNote5.y ) and 
    ((submarine.y + submarine.height/2) > musicNote5.y ) ) then
        -- function that cancels the droptimer 
        timer.cancel(DropTimer)
        StopImage = 0
        if (musicNote1.isVisible == true) then
            musicNote1.isVisible = false
            timer.cancel(musicNote1Timer)
            HeartLossText.isVisible = true
            submarine.x = display.contentWidth/10
            submarine.y = display.contentHeight/2
            musicNote1.y = 0
            if (Hearts == 3) then
                heart3.isVisible = false
                Hearts = Hearts - 1
            elseif (Hearts == 2) then
                heart2.isVisible = false            
                Hearts = Hearts - 1
            elseif (Hearts == 1) then 
                heart1.isVisible = false
                Hearts = Hearts - 1
                gotoYouLose()
            end
            bkg_image.anchorX = 0
            bkg_image.x = 0
            bkg_image.y = display.contentCenterY
            bkg_image.width = display.contentWidth*2
            bkg_image.height = display.contentHeight
        elseif (musicNote2.isVisible == true) then
            musicNote2.isVisible = false
            timer.cancel(musicNote2Timer)
            HeartLossText.isVisible = true
            submarine.x = display.contentWidth/10
            submarine.y = display.contentHeight/2
            musicNote2.y = 0
            if (Hearts == 3) then
                heart3.isVisible = false
                Hearts = Hearts - 1
            elseif (Hearts == 2) then
                heart2.isVisible = false            
                Hearts = Hearts - 1
            elseif (Hearts == 1) then
                heart1.isVisible = false
                Hearts = Hearts - 1
                gotoYouLose()
            end
            bkg_image.anchorX = 0
            bkg_image.x = 0
            bkg_image.y = display.contentCenterY
            bkg_image.width = display.contentWidth*2
            bkg_image.height = display.contentHeight
        elseif (musicNote3.isVisible == true) then
            musicNote3.isVisible = false
            timer.cancel(musicNote3Timer)
            HeartLossText.isVisible = true
            submarine.x = display.contentWidth/10
            submarine.y = display.contentHeight/2
            musicNote3.y = 0
            if (Hearts == 3) then
                heart3.isVisible = false
                Hearts = Hearts - 1
            elseif (Hearts == 2) then
                heart2.isVisible = false            
                Hearts = Hearts - 1
            elseif (Hearts == 1) then
                heart1.isVisible = false
                Hearts = Hearts - 1
                gotoYouLose()
            end
            bkg_image.anchorX = 0
            bkg_image.x = 0
            bkg_image.y = display.contentCenterY
            bkg_image.width = display.contentWidth*2
            bkg_image.height = display.contentHeight
        elseif (musicNote4.isVisible == true) then
            musicNote4.isVisible = false
            timer.cancel(musicNote4Timer)
            HeartLossText.isVisible = true
            submarine.x = display.contentWidth/10
            submarine.y = display.contentHeight/2
            musicNote4.y = 0
            if (Hearts == 3) then
                heart3.isVisible = false
                Hearts = Hearts - 1
            elseif (Hearts == 2) then
                heart2.isVisible = false            
                Hearts = Hearts - 1
            elseif (Hearts == 1) then
                heart1.isVisible = false
                Hearts = Hearts - 1
                gotoYouLose()
            end
            bkg_image.anchorX = 0
            bkg_image.x = 0
            bkg_image.y = display.contentCenterY
            bkg_image.width = display.contentWidth*2
            bkg_image.height = display.contentHeight
        elseif (musicNote5.isVisible == true) then
            musicNote5.isVisible = false
            timer.cancel(musicNote5Timer)
            HeartLossText.isVisible = true
            submarine.x = display.contentWidth/10
            submarine.y = display.contentHeight/2
            musicNote5.y = 0
            if (Hearts == 3) then
                heart3.isVisible = false
                Hearts = Hearts - 1
            elseif (Hearts == 2) then
                heart2.isVisible = false            
                Hearts = Hearts - 1
            elseif (Hearts == 1) then
                heart1.isVisible = false
                Hearts = Hearts - 1
                gotoYouLose()
            end
            bkg_image.anchorX = 0
            bkg_image.x = 0
            bkg_image.y = display.contentCenterY
            bkg_image.width = display.contentWidth*2
            bkg_image.height = display.contentHeight
        end
        timer.performWithDelay(1000, HideText)
        timer.performWithDelay(1000, DropMusicNotes)
    end
end

local function MoveMusicNote1( )
    musicNote1.y = musicNote1.y + 20
    if (musicNote1.y >= display.contentHeight) then
        Dropped = true
        musicNote1.y = display.contentHeight/15
        musicNote1.isVisible = false
        timer.cancel(musicNote1Timer)
    end
    if (((submarine.x - submarine.width/2) < musicNote1.x ) and
    ((submarine.x + submarine.width/2) > musicNote1.x ) and 
    ((submarine.y - submarine.height/2) < musicNote1.y ) and 
    ((submarine.y + submarine.height/2) > musicNote1.y ) ) then
        CheckIfHit()
    end
    if (musicNote1.isVisible == true) then
        musicNote1Timer = timer.performWithDelay(100, MoveMusicNote1)
    end
end

local function MoveMusicNote2( )
    musicNote2.y = musicNote2.y + 20
    if (musicNote2.y >= display.contentHeight) then
        Dropped = true
        musicNote2.y = display.contentHeight/15
        musicNote2.isVisible = false
        timer.cancel(musicNote2Timer)
    end
    if (((submarine.x - submarine.width/2) < musicNote2.x ) and
    ((submarine.x + submarine.width/2) > musicNote2.x ) and 
    ((submarine.y - submarine.height/2) < musicNote2.y ) and 
    ((submarine.y + submarine.height/2) > musicNote2.y ) ) then
        CheckIfHit()
    end
    if (musicNote2.isVisible == true) then
        musicNote2Timer = timer.performWithDelay(100, MoveMusicNote2)
    end
end

local function MoveMusicNote3( )
    musicNote3.y = musicNote3.y + 20
    if (musicNote3.y >= display.contentHeight) then
        Dropped = true
        musicNote3.y = display.contentHeight/15
        musicNote3.isVisible = false
        timer.cancel(musicNote3Timer)
    end
    if (((submarine.x - submarine.width/2) < musicNote3.x ) and
    ((submarine.x + submarine.width/2) > musicNote3.x ) and 
    ((submarine.y - submarine.height/2) < musicNote3.y ) and 
    ((submarine.y + submarine.height/2) > musicNote3.y ) )then
        CheckIfHit()
    end
    if (musicNote3.isVisible == true) then
        musicNote3Timer = timer.performWithDelay(100, MoveMusicNote3)
    end
end

local function MoveMusicNote4( )
    musicNote4.y = musicNote4.y + 20
    if (musicNote4.y >= display.contentHeight) then
        Dropped = true
        musicNote4.y = display.contentHeight/15
        musicNote4.isVisible = false
        timer.cancel(musicNote4Timer)
    end
    if (((submarine.x - submarine.width/2) < musicNote4.x ) and
    ((submarine.x + submarine.width/2) > musicNote4.x ) and 
    ((submarine.y - submarine.height/2) < musicNote4.y ) and 
    ((submarine.y + submarine.height/2) > musicNote4.y ) ) then
        CheckIfHit()
    end
    if (musicNote4.isVisible == true) then
        musicNote4Timer = timer.performWithDelay(100, MoveMusicNote4)
    end
end

local function MoveMusicNote5( )
    musicNote5.y = musicNote5.y + 20
    if (musicNote5.y >= display.contentHeight) then
        Dropped = true
        musicNote5.y = display.contentHeight/15
        musicNote5.isVisible = false
        timer.cancel(musicNote5Timer)
    end
    if (((submarine.x - submarine.width/2) < musicNote5.x ) and
    ((submarine.x + submarine.width/2) > musicNote5.x ) and 
    ((submarine.y - submarine.height/2) < musicNote5.y ) and 
    ((submarine.y + submarine.height/2) > musicNote5.y ) ) then
        CheckIfHit()
    end
    if (musicNote5.isVisible == true) then
        musicNote5Timer = timer.performWithDelay(100, MoveMusicNote5)
    end
end

function DropMusicNotes( event )
        choseRandomNote = math.random(1,5)
    if (choseRandomNote == 1) then
        Dropped = false
        musicNote1.isVisible = true
        musicNote1.y = display.contentHeight/15
        MoveMusicNote1()
        musicNote1.x = math.random(0, display.contentWidth)
        DropTimer = timer.performWithDelay(4000, DropMusicNotes)
    elseif (choseRandomNote == 2) then
        Dropped = false
        musicNote2.y = display.contentHeight/15
        musicNote2.isVisible = true
        MoveMusicNote2()
        musicNote2.x = math.random(100, 100)--display.contentWidth)
        DropTimer = timer.performWithDelay(4000, DropMusicNotes)
    elseif (choseRandomNote == 3) then
        Dropped = false
        musicNote3.y = display.contentHeight/15
        musicNote3.isVisible = true
        MoveMusicNote3()
        musicNote3.x = math.random(0, display.contentWidth)
        DropTimer = timer.performWithDelay(4000, DropMusicNotes)
    elseif (choseRandomNote == 4) then
        Dropped = false
        musicNote4.y = display.contentHeight/15
        musicNote4.isVisible = true
        MoveMusicNote4()
        musicNote4.x = math.random(0, display.contentWidth)
        DropTimer = timer.performWithDelay(4000, DropMusicNotes)
    elseif (choseRandomNote == 5) then
        Dropped = false
        musicNote5.y = display.contentHeight/15
        musicNote5.isVisible = true
        MoveMusicNote5()
        musicNote5.x = math.random(0, display.contentWidth)
        DropTimer = timer.performWithDelay(4000, DropMusicNotes)
    end
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
    bkg_image = display.newImageRect("Images/level1_screen.png", display.contentWidth, display.contentHeight)
    bkg_image.anchorX = 0
    bkg_image.x = 0
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth*2
    bkg_image.height = display.contentHeight

    musicNote1 = display.newImageRect("Images/musicNote1.png", 200, 200)
    musicNote1.x = 600
    musicNote1.y = display.contentHeight/20
    musicNote1.width = 100
    musicNote1.height = 100
    musicNote1.isVisible = false

    musicNote2 = display.newImageRect("Images/musicNote2.png", 200, 200)
    musicNote2.x = 600
    musicNote2.y = display.contentHeight/20
    musicNote2.width = 100
    musicNote2.height = 100
    musicNote2.isVisible = false

    musicNote3 = display.newImageRect("Images/musicNote3.png", 200, 200)
    musicNote3.x = 600
    musicNote3.y = display.contentHeight/20
    musicNote3.width = 100
    musicNote3.height = 100
    musicNote3.isVisible = false

    musicNote4 = display.newImageRect("Images/musicNote4.png", 200, 200)
    musicNote4.x = 600
    musicNote4.y = display.contentHeight/20
    musicNote4.width = 100
    musicNote4.height = 100
    musicNote4.isVisible = false

    musicNote5 = display.newImageRect("Images/musicNote5.png", 200, 200)
    musicNote5.x = 600
    musicNote5.y = display.contentHeight/20
    musicNote5.width = 50
    musicNote5.height = 50
    musicNote5.isVisible = false

    submarine = display.newImage("Images/yellowSubmarine.png", 200, 200)
    submarine.x = display.contentWidth/10
    submarine.y = display.contentHeight/2

    DownArrow = display.newImageRect("Images/DownArrow.png", 100, 100)
    DownArrow.x = display.contentWidth/1.05
    DownArrow.y = display.contentHeight/1.07

    UpArrow = display.newImageRect("Images/UpArrow.png", 100, 100)
    UpArrow.x = display.contentWidth/1.05
    UpArrow.y = display.contentHeight/1.26

    LeftArrow = display.newImageRect("Images/LeftArrow.png", 100, 100)
    LeftArrow.x = display.contentWidth/20
    LeftArrow.y = display.contentHeight/1.07

    RightArrow = display.newImageRect("Images/RightArrow.png", 100, 100)
    RightArrow.x = display.contentWidth/6
    RightArrow.y = display.contentHeight/1.07

    heart1 = display.newImageRect("Images/heart.png", 100, 100)
    heart1.x = display.contentWidth/1.1
    heart1.y = display.contentHeight/15

    heart2 = display.newImageRect("Images/heart.png", 100, 100)
    heart2.x = display.contentWidth/1.25
    heart2.y = display.contentHeight/15

    heart3 = display.newImageRect("Images/heart.png", 100, 100)
    heart3.x = display.contentWidth/1.45
    heart3.y = display.contentHeight/15

    HeartLossText = display.newText("AVOID THE MUSIC NOTES! You lost a life", display.contentWidth/2, display.contentHeight/3, nil, 50)
    HeartLossText.isVisible = false

    Cave = display.newImageRect("Images/Cave.png", 400, display.contentHeight)
    Cave.anchorX  = 0
    Cave.x = display.contentWidth/1.5
    Cave.y = display.contentHeight/2
    Cave.alpha = 0

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

        -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( Cave )
    sceneGroup:insert( musicNote1 )    
    sceneGroup:insert( musicNote2 )
    sceneGroup:insert( musicNote3 )
    sceneGroup:insert( musicNote4 )
    sceneGroup:insert( musicNote5 )
    sceneGroup:insert( DownArrow )
    sceneGroup:insert( UpArrow )
    sceneGroup:insert( LeftArrow )
    sceneGroup:insert( RightArrow )
    sceneGroup:insert( submarine )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( HeartLossText )


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

    elseif ( phase == "did" ) then
        LeftArrow:addEventListener("touch", MoveLeft)
        RightArrow:addEventListener("touch", MoveRight)
        UpArrow:addEventListener("touch", MoveUp)
        DownArrow:addEventListener("touch", MoveDown)
        timer.performWithDelay(400, DropMusicNotes)

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
