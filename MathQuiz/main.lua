-----------------------------------------------------------------------------------------
-- Title: MathFun
-- Name: Your Name
-- Course: ICS2O/3C
-- This program shows a math game with random addition, 
-- subtraction, multiplication, and division questions.
-----------------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------------
-- Title: NumericTextFields
-- Name:  Tim 
-- Course: ICS2O
-- This program displays a math question and asks the user to answer in a numeric textfield.
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- set the background color
display.setDefault("background", 115/255, 56/255, 253/255)

-------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-------------------------------------------------------------------------------------------
local questionObject
local correctObject
local incorrectObject
local numericTextFields
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer
local points = 0
local youWin
local gameOver
local randomOperator
local randomNumber3
local TOTALSECONDS = 11
local secondsLeft = 11
local clockText
local countdownTimer
local lives = 3
local heart1
local heart2
local heart3
local youWinImage
local youLoseImage
number = 0

-------------------------------------------------------------------------------------------
-- SOUNDS
-------------------------------------------------------------------------------------------

-- background sound
local backgroundSound = audio.loadSound("Sounds/background sound.mp3") -- setting a variable to the mp3 file
local backgroundSoundChannel = audio.play(backgroundSound,{loops = -1})

-- corrrect sound
local correctSound = audio.loadSound("Sounds/correct sound.mp3") -- setting a variable to the mp3 file 
local correctSoundChannel

-- wrong sound
local wrongSound = audio.loadSound("Sounds/wrong sound.mp3") -- setting a variable to the mp3 file 
local wrongSoundChannel

-- you lose sound
local gameOverSound = audio.loadSound("Sounds/game over sound.mp3") -- setting a variable to the mp3 file 
local gameOverSoundChannel

-- you win sound 
local youWinSound = audio.loadSound("Sounds/you win sound.mp3") -- setting a variable to the mp3 file 
local youWinSoundChannel

-------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------------------------------------------------------

local function AskQuestion()
	-- generate a random number between 1 and 2
	-- *** MAKE SURE TO DECLARE THIS VARIABLE ABOVE
	randomOperator = math.random(1,4) 
	incorrectObject.isVisible = false

	-- if the randomOperator is 1, then do addition
	if (randomOperator == 1) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 20)
		randomNumber2 = math.random(1, 20)

		-- calculate the correct answer
		correctAnswer = randomNumber1 + randomNumber2
	 	-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " ="

	-- otherwise, if the random operator is 2, do subtraction
	elseif (randomOperator == 2) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 20)
		randomNumber2 = math.random(1, 20)

		if (randomNumber1 > randomNumber2) then
			-- calculate the correct answer
			correctAnswer = randomNumber1 - randomNumber2

			-- create question in text object
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " ="
		
		else 
			randomNumber3 = randomNumber1
			randomNumber1 = randomNumber2
			randomNumber2 = randomNumber3
			-- calculate the correct answer
			correctAnswer = randomNumber1 - randomNumber2

			-- create question in text object
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " ="
		end

	-- otherwise, if the random operator is 2, do subtraction
	elseif (randomOperator == 3) then	
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)

		randomNumber3 = randomNumber1 * randomNumber2

		-- calculate the correct answer
		correctAnswer = randomNumber3 / randomNumber2
		print("***correctAnswer = ".. correctAnswer)

		-- create question in text object
		questionObject.text = randomNumber3 .. " / " .. randomNumber2 .. " ="

	-- otherwise, if the random operator = 4, do multiplication
	elseif (randomOperator == 4) then
			-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)

		-- calculate the correct answer
		correctAnswer = randomNumber1 * randomNumber2
		-- create question in text object 
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " ="
	end
end

local function UpdateTime()

	-- decrement the number of seconds 
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then
		-- reset the number of seconds left 
		secondsLeft = TOTALSECONDS
		lives = lives - 1
		-- tell the user the correct answer 
		incorrectObject.isVisible = true
		wrongSoundChannel = audio.play(wrongSound)
		incorrectObject.text = "Sorry,that's incorrect! The correct answer is\n" .. 
		correctAnswer .. ". Try again!"
		timer.performWithDelay(3000, HideIncorrect)
		timer.performWithDelay(3000, AskQuestion)

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A LOSE IMAGE AND CANCEL THE TIMER
		-- REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
		if (lives == 2) then
			heart1.isVisible = false
		elseif (lives == 1) then
			heart2.isVisible = false
		elseif (lives == 0) then
			heart3.isVisible = false
			audio.stop(backgroundSoundChannel)
			audio.stop(wrongSoundChannel)
			gameOverSoundChannel = audio.play(gameOverSound)
			clockText.isVisible = false
			incorrectObject.isVisible = true
			timer.performWithDelay(2000)
			incorrectObject.isVisible = false
			numericTextFields.isVisible = false
			youLoseImage.isVisible = true
			audio.stop(wrongSoundChannel)
			timer.cancel(countdownTimer)
		end
	end
end

-- function that call the timer 
local function StartTimer(event)
	-- create a countdown timer that loops infinitely
	countdownTimer = timer.performWithDelay(1000, UpdateTime, 0)
end

local function StopSounds()
	-- stop all sounds after winning or losing
	audio.stop(youWinSoundChannel)
	audio.stop(gameOverSoundChannel)
end

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end


local function NumericFieldListener( event)

	-- user begins editing "numericField"
	if (event.phase == "begin") then

		-- clear txt field
		event.target.text = ""

	elseif (event.phase == "submitted") then
		secondsLeft = TOTALSECONDS
		-- when the answer is submitted (enter key is pressed) set user input to user's answer
		userAnswer = tonumber(event.target.text)
		-- if the user's answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			secondsLeft = TOTALSECONDS
			correctObject.isVisible = true
			correctSoundChannel = audio.play(correctSound)
			incorrectObject.isVisible = false
			timer.performWithDelay(1500, HideCorrect)

			-- give a point if user gets the correct answer
			points = points + 1

			-- update it in the display object
			pointsText.text = "Points = " .. points

			if (points >= 5) then
				clockText.isVisible = false
				correctObject.isVisible = false
				numericTextFields.isVisible = false
				audio.stop(backgroundSoundChannel)
				youWinImage.isVisible = true
				audio.stop(correctSoundChannel)
				youWinSoundChannel = audio.play(youWinSound)
				timer.cancel(countdownTimer)

				-- make the youWinImage rotate
				local function RotateYouWin(event)
					youWinImage:rotate(20)
					number = number + 20
					if (number < 360) then
						timer.performWithDelay(100,RotateYouWin)
					end
				end
				RotateYouWin()
			end

		-- inside the else means they got it wrong
		else
			incorrectObject.isVisible = true
			wrongSoundChannel = audio.play(wrongSound)
			incorrectObject.text = "Sorry,that's incorrect! The correct answer is\n" .. 
			correctAnswer .. ". Try again!"
		
		 	-- update it in the display object
			timer.performWithDelay(3000, HideIncorrect)
			lives = lives - 1

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A LOSE IMAGE AND CANCEL THE TIMER
		-- REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
		if (lives == 2) then
			heart1.isVisible = false
		elseif (lives == 1) then
			heart2.isVisible = false
		elseif (lives == 0) then
			heart3.isVisible = false
			audio.pause(backgroundSoundChannel)
			audio.stop(wrongSoundChannel)
			gameOverSoundChannel = audio.play(gameOverSound)
			clockText.isVisible = false
			incorrectObject.isVisible = true
			timer.performWithDelay(2000)
			incorrectObject.isVisible = false
			numericTextFields.isVisible = false
			youLoseImage.isVisible = true
			timer.cancel(countdownTimer)
		end
	end
		event.target.text = ""
	end
end
------------------------------------------------------------------------------------------------------
-- OBJECT CREATION
------------------------------------------------------------------------------------------------------

-- displays a question and sets the color
questionObject = display.newText("", display.contentWidth/3, display.contentHeight * 2/3, nil, 60)
questionObject:setTextColor(60/255, 185/255, 51/255)
questionObject.isVisible = true


-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 12

-- create the lives to display on the screen
heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 12

-- create the lives to display on the screen
heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 12

-- create the correct text object and make it invisible
correctObject = display.newText("Correct!", display.contentWidth/1.4, display.contentHeight * 2/3, nil, 50)
correctObject:setTextColor(66/255, 226/255, 26/255)
correctObject.isVisible = false

-- create numeric field
numericTextFields = native.newTextField( display.contentWidth/1.9, display.contentHeight * 2/3, 150, 100)
numericTextFields.inputType = "number"
-- add the event listener for the numeric field
numericTextFields:addEventListener("userInput", NumericFieldListener)

-- create the incorrect text object and make it invisible
incorrectObject = display.newText("", display.contentWidth/2, display.contentHeight/3, nil, 50)
incorrectObject:setTextColor(226/255, 26/255, 26/255)
incorrectObject.isVisible = false

-- display the amount of points as a text object
pointsText = display.newText("Points = " .. points, display.contentWidth/1.2, display.contentHeight/5, nil, 50)

clockText = display.newText("",  display.contentWidth/2, display.contentHeight/2, nil, 75)
clockText:setTextColor(40/255, 239/255, 232/255)

youWinImage = display.newImageRect("Images/you win.png", display.contentWidth, display.contentHeight)
youWinImage.x = 513
youWinImage.y = 385
youWinImage.isVisible = false

youLoseImage = display.newImageRect("Images/you lose.jpg", display.contentWidth, display.contentHeight)
youLoseImage.anchorX = 0
youLoseImage.anchorY = 0
youLoseImage.isVisible = false

AskQuestion()
StartTimer()