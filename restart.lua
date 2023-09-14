local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- requires 


local storyboard = require ("storyboard")
local scene = storyboard.newScene()
local mydata = require( "mydata" )
local score = require( "score" )
local jogo = require("game")
local physics = require("physics")
local ball
local gropBalls

-- background

function restartGame(event)
     if event.phase == "ended" then
		--saveScore()
		storyboard.removeScene("game")
		storyboard.gotoScene("menu")
		storyboard.removeScene("restart")
	    storyboard.purgeAll()
     end
end

function showStart()
	print("show start")
	startTransition = transition.to(restart,{time=200, alpha=1})
	scoreTextTransition = transition.to(scoreText,{time=600, alpha=1})
	scoreTextTransition = transition.to(bestText,{time=600, alpha=1})
end

function showScore()
	print("show score")
	scoreTransition = transition.to(scoreBg,{time=600, y=display.contentCenterY,onComplete=showStart})
	
end

function showGameOver()
	print("show game over")
	fadeTransition = transition.to(gameOver,{time=600, alpha=1,onComplete=showScore})
end

function loadScore()
	local prevScore = score.load()
	if prevScore ~= nil then
		if prevScore <= mydata.score then
			score.set(mydata.score)
		else 
			score.set(prevScore)	
		end
	else 
		score.set(mydata.score)	
		score.save()
	end
end

function saveScore()
	score.save()
end

function scene:createScene(event)
 
local screenGroup = self.view

	
-- bkg = display.setDefault( "background", 3, 5, 5 )
--local barra = display.newImage( "beam_long.png", 0, 0 ) 
--screenGroup:insert(bkg)
 
local bkg = display.newImage( "bg2.jpg", centerX, centerY )    
screenGroup:insert(bkg)
 
 
 -------------- Floor------------------------------
local borderBottom = display.newRect( 0, _H, _W*2, 20 )
borderBottom:setFillColor( 1, 1, 1, 1)    -- make invisible

-- make invisible

screenGroup:insert(borderBottom)

 --display.newRect( x, y, width, height ) 
  
--local borderTop1 = display.newRect( 0, 0, _W*2 , 20 )
--borderTop1:setFillColor( "black")    -- make invisible
 
--screenGroup:insert(borderTop1)
 
 --local borderLeft = display.newRect( 0, 0, 20 , _H*2 )
--borderLeft:setFillColor("black" )    -- make invisible

--screenGroup:insert(borderLeft)


--local borderRight = display.newRect( _W , 20, 20, _H*2 )
--borderRight:setFillColor("black")   -- make invisible

--screenGroup:insert(borderRight)
	
	 
	
	
	gameOver = display.newImageRect("gameOver.png",200,100)
	gameOver.anchorX = 0.5
	gameOver.anchorY = 0.5
	gameOver.x = display.contentCenterX 
	gameOver.y = display.contentCenterY
	gameOver.alpha = 0
	screenGroup:insert(gameOver)
	
	scoreBg = display.newImageRect("menuBg.png",280,193)
	scoreBg.anchorX = 0.5
	scoreBg.anchorY = 0.5
  scoreBg.x = display.contentCenterX
  scoreBg.y = display.contentHeight + 500
  screenGroup:insert(scoreBg)
	
	restart = display.newImageRect("start_btn.png",80,35)
	restart.anchorX = 0.5
	restart.anchorY = 1
	restart.x = display.contentCenterX
	restart.y = display.contentCenterY + 200
	restart.alpha = 0
	screenGroup:insert(restart)
	
	scoreText = display.newText(mydata.score,display.contentCenterX + 60,
	display.contentCenterY - 40, native.systemFont, 20)
	scoreText:setFillColor(0,0,0)
	scoreText.alpha = 0 
	screenGroup:insert(scoreText)
		
	bestText = score.init({
	fontSize = 20,
	font = "Helvetica",
	x = display.contentCenterX + 60,
	y = display.contentCenterY + 35,
	maxDigits = 7,
	leadingZeros = false,
	filename = "scorefile.txt",
	})
	bestScore = score.get()
	bestText.text = bestScore
	bestText.alpha = 0
	bestText:setFillColor(0,0,0)
	screenGroup:insert(bestText)
	
end

function scene:enterScene(event)

	 --jogo.groupBalls:removeSelf()
	print("passou por aquii")
   --storyboard.removeScene("game")
   --storyboard.purgeScene( "game" )
   restart:addEventListener("touch", restartGame)
	showGameOver()
	loadScore()
	saveScore()
	print("passou aqui tambem")
	
end

function scene:exitScene(event)
	restart:removeEventListener("touch", restartGame)
	transition.cancel(fadeTransition)
	transition.cancel(scoreTransition)
	transition.cancel(scoreTextTransition)
	transition.cancel(startTransition)
end

function scene:destroyScene(event)

end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)

return scene













