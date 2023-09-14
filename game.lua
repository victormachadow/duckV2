local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight



------------------------------------------------------------------
--LIBRARIES
------------------------------------------------------------------


local storyboard = require("storyboard")


local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
 
local mydata = require( "mydata" )

local physics = require("physics")

physics.start()
--physics.setDrawMode( "hybrid" )
physics.setGravity(0,10) 

mydata.score = 0

--variaveis
local esq = true
local myName
local probability = 3
local displayBall
local sprites3
local groupEnemy
local enemies 
local bolax
local player
local group
local timeText
--local sequencesPato
--local sheetPato
local sheet
local sheet2
local sprites
local sprites2


--[[
---------objetos pontuaveis----------

local frutas = { maca , cranio , escudo , laranja , linguica }

local maca = {  img="" , ponto=   , tam = }

local cranio = {  img="" , ponto=   , tam = }

local escudo = {  img="" , ponto=   , tam = }

local laranja = {  img="" , ponto=   , tam = }

local linguica = {  img="" , ponto=   , tam = }

por ai vai...

--]]

local grito = audio.loadSound( "scream.mp3" )
audio.setVolume( 0.1 )

 local sequencesPato = {
    -- first sequence (consecutive frames)
    
        name = "normalRun",
        start = 1,
        count = 4,
        --loopCount=1, -- seta quantidade de vezes q ele ira executar
        time = 800,
       
    }



 local sheetPato =
{
    width = 205,
    height = 170,
    numFrames = 4,
    sheetContentWidth = 820,  --width of original 1x size of entire sheet
    sheetContentHeight = 170
}

 local sheetDead =
{
    width = 208,
    height = 295,
    numFrames = 8,
    sheetContentWidth = 1664,  --width of original 1x size of entire sheet
    sheetContentHeight = 295
}


local sequencesDead = {
    -- first sequence (consecutive frames)
    
        name = "normalRun",
        start = 1,
        count = 8,
        loopCount=1, -- seta quantidade de vezes q ele ira executar
        time = 800,
       
    }





    local function onLocalCollision( self, event )
     
    if ( event.phase == "began" ) then
      if ( event.other.myName == "pato") then print ( "pato tocado")
        audio.play( grito )
        mydata.score = tonumber( timeText.text )
        timeText.text = mydata.score
        timer.cancel(timerID)
        timer.cancel(timerBalls)
        timer.cancel(timerLoop)
        Runtime:removeEventListener( "touch" , touched2 )

        
        sprites3.isVisible=true
        sprites3.x =player.x
        sprites3.y =player.y
        sprites.isVisible=false
        sprites2.isVisible=false
        sprites3:play()
        display.remove(enemies)

      
      timer.performWithDelay(2000,function() 
         
        
        --display.remove(enemies)
        --player:removeEventListener( onLocalCollision , player )
       
        storyboard.gotoScene( "restart")

        end , 1 )

      end
      
      end 
    
    
end 

--[[
   local function onLocalCollision2( self, event )
     
    if ( event.phase == "began" ) then
      if ( event.other.myName == "bola") then print ( self.myName)
      

      end
      

       
    elseif ( event.phase == "ended" ) then
       --display.remove(self)
       --self:removeEventListener(onLocalCollision , self )
       self:removeEventListener( "onLocalCollision2" , self )
       --display.remove(enemies)
    end
       
    
    
end 
 
 
 --]]
 
 
 
------------------------------------------------------------------
--GAME FUNCTIONS
------------------------------------------------------------------



function touched2(event)

 sprites:play()
 sprites2:play()
 
 if ( event.phase=="began"  ) then
 
 if ( event.x < player.x )then
 
 esq = true
 
 if(esq) then  sprites2.isVisible=false
  sprites.isVisible=true
  
  end

 player:applyLinearImpulse( -2.9 , 0 ,  player.x , player.y )
  end
 
 if ( event.x > player.x )then
 
 if ( esq ) then  sprites2.isVisible=true
  sprites.isVisible=false  end

 esq = false
 
 player:applyLinearImpulse( 2.9 , 0 ,  player.x , player.y )
  end
 
 
 end

end






 






-- Called when the scene's view does not exist:
function scene:createScene(event)

    --groupBkg = display.newGroup()

     group = self.view
     enemies = display.newGroup()


local bkg = display.newImage( "bg2.jpg", centerX, centerY )  
group:insert(bkg)


timeText = display.newText( "0", display.contentCenterX + 80 , 40 , native.systemFontBold, 26 )
timeText:setFillColor( "black" )
group:insert(timeText)

local borderBottom = display.newRect( 0, _H, _W*2, 20 )
borderBottom:setFillColor( 1, 1, 1, 1)    -- make invisible
physics.addBody( borderBottom, "static", borderBodyElement )
group:insert(borderBottom)

--borderBottom.collision = onLocalCollision2
--borderBottom:addEventListener( "collision", borderBottom  )
--group:insert( borderBottom )
 
--local borderRight = display.newRect( _W+15 , 20, 20, _H*2 )
--borderRight:setFillColor( 1, 1, 1, 1)   -- make invisible
--physics.addBody( borderRight, "static", borderBodyElement )
--group:insert(borderRight)

--group:insert(sequencesPato)
--group:insert(sheetPato)


 sheet = graphics.newImageSheet( "SS_duck_left_140.png", sheetPato ) -- left
 sheet2 = graphics.newImageSheet( "SS_duck_right_140.png", sheetPato ) --right
 sheet3 = graphics.newImageSheet( "SS_duck_death_left_140.png", sheetDead ) 

--group:insert(sheet)
--group:insert(sheet2)


sprites = display.newSprite( sheet , sequencesPato )

sprites2 = display.newSprite( sheet2 , sequencesPato )

sprites3 =  display.newSprite( sheet3 , sequencesDead) 

sprites.isVisible=false
sprites3.isVisible=false

group:insert(sprites)
group:insert(sprites2)
group:insert(sprites3)


player = display.newImage( "duck_140.png", centerX , centerY+200  )
--local player = display.newCircle( centerX, centerY, 35 )
physics.addBody( player , "dinamic" )
player.isVisible=false
player.isFixedRotation = true
player.linearDamping = 3
--player.mass=0.1
player.myName="pato"
--player.collision = onLocalCollision2
--player:addEventListener( "collision", player )
group:insert(player)

--bkg:addEventListener("touch",playerTouched)
Runtime:addEventListener("touch", touched2 )

 
 
end





function update()

if ( player.x <= 0) then player.x = 0  end
if ( player.x >=  _W ) then player.x = _W-5  end
sprites.x = player.x
sprites.y = player.y
sprites2.x = player.x
sprites2.y = player.y


for i=enemies.numChildren,1, -1 do 

if ( enemies[i].y  > 600  or enemies[i].x  >= _W )
then display.remove(enemies[i])
end



end


end


function spawnEnemy()

bolax =  math.random( 0 , 800 )
enemy = display.newImage( "meteoro_40.png", bolax , 0 )
enemy.linearDamping = 1
physics.addBody( enemy ) 
enemy.myName = "bola"
enemy.collision = onLocalCollision
enemy:addEventListener( "collision", enemy )
--displayBall:insert(enemy)
 enemies:insert(enemy)


return enemy


end




function caiBola()
print(probability)
num = math.random(0 , 10)
if ( num < 8 ) then
 for i = 0,  math.random( 0 , probability ) do 
 local enemy = spawnEnemy()

 --table.insert( enemies , enemy)
 if(num < 5 ) then
 --enemy:applyLinearImpulse( 1, 0, enemy.x , enemy.y )
 enemy:applyLinearImpulse(0.3, 0.3, enemy.x , enemy.y )
 elseif( num >= 5 ) then
 --enemy:applyLinearImpulse( -1, 0, enemy.x , enemy.y )
 enemy:applyLinearImpulse( -0.3, 0.3, enemy.x , enemy.y )
 end
 
  -- Display group da cena vai inserindo as bolas criadas

 
end
end
end


function probabilit()

probability = math.random(0,8)

end





local function text( event )
         
  cont = event.count

  
  timeText.text = cont

 
    
end

 

 
 
---------------------------------------------------------------------------------
-- STORYBOARD FUNCTIONS
---------------------------------------------------------------------------------
 

 

 
-- Called immediately after scene has moved onscreen:
function scene:enterScene(event)
 
 group = display.newGroup()
 --group = self.view
timer.performWithDelay( 8000  , probabilit , -1 ) 
timerID = timer.performWithDelay( 700, text, -1 )
timerLoop = timer.performWithDelay( 1 , update , -1 )
timerBalls = timer.performWithDelay( 800 , caiBola , -1 )

 
 storyboard.removeScene("menu")

 
 
end
 
 
-- Called when scene is about to move offscreen:
function scene:exitScene(event)
    local group = group
  
    storyboard.removeAll()
    --storyboard.purgeAll()
 
 
end
 

 
 
-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene(event)
    local group = self.view

    
 
end


 
 
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


--Runtime:addEventListener( "touch", touched2 )

 
---------------------------------------------------------------------------------
 
return scene