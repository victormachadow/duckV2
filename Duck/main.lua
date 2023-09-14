local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight


--variaveis
local esq = true
local myName
local group = display.newGroup()
local groupEnemy
local enemies = {}
local bolax
local physics = require("physics")
physics.start()
--physics.setDrawMode( "hybrid" )
--local scene = storyboard.newScene()

--[[
function scene:createScene( event )
   group = self.view
--]] 

local bkg = display.newImage( "bg2.jpg", centerX, centerY )
local borderRight = display.newRect( _W+15 , 20, 20, _H*2 )
borderRight:setFillColor( 1, 1, 1, 1)   -- make invisible
physics.addBody( borderRight, "static", borderBodyElement )
print( display.actualContentWidth )
--print(_W)
print(_H)









  
local function onLocalCollision( self, event )
     
    if ( event.phase == "began" ) then
      if ( event.other.myName == "pato") then print ( "pato tocado") end
       -- print( self.myName  )
        --display.remove(self.myName)
        --self.myName:removeSelf()
       
    elseif ( event.phase == "ended" ) then
       display.remove(self)
    end
       
    
    
end 

local function onLocalCollision2( self, event )
     
    if ( event.phase == "began" ) then
    --if ( event.other == "pato") then print ( "pato tocado") end
       -- print( self.myName  )
        --display.remove(self.myName)
        --self.myName:removeSelf()
       
    elseif ( event.phase == "ended" ) then
       
    end
       
    
    
end
   
   
  
  
  
  
local borderBottom = display.newRect( 0, _H, _W*2, 20 )
borderBottom:setFillColor( 1, 1, 1, 1)		-- make invisible
physics.addBody( borderBottom, "static", borderBodyElement )
--borderBottom.myName="chao"
--borderBottom.collision = onLocalCollision
--borderBottom:addEventListener( "collision", borderBottom  )
--group:insert( borderBottom )
 


local sequencesPato = {
    -- first sequence (consecutive frames)
    
        name = "normalRun",
        start = 1,
        count = 4,
        time = 800,
       
    }



local sheetPato =
{
    width = 100,
    height = 100,
    numFrames = 4,
    sheetContentWidth = 400,  --width of original 1x size of entire sheet
    sheetContentHeight = 100
}



local sheet = graphics.newImageSheet( "SS_duck_80.png", sheetPato )
local sheet2 = graphics.newImageSheet( "SS_duck_80_i.png", sheetPato )


local sprites = display.newSprite( sheet , sequencesPato )

local sprites2 = display.newSprite( sheet2 , sequencesPato )
sprites.isVisible=false



player = display.newImage( "duck-02.png", centerX , centerY  )
--local player = display.newCircle( centerX, centerY, 35 )
physics.addBody( player , "dinamic" )
player.isVisible=false
player.isFixedRotation = true
player.linearDamping = 3
--player.mass=0.1
player.myName="pato"
player.collision = onLocalCollision2
player:addEventListener( "collision", player )





 
--end

function touched(event)

 if ( event.phase=="began"  ) then
 
 if ( event.x < player.x )then
 
 esq = true
 
 if(esq) then  player.xScale = 1 end

 player:applyLinearImpulse( -0.9 , 0 ,  player.x , player.y )
  end
 
 if ( event.x > player.x )then
 
 if ( esq ) then player.xScale = -1 end

 esq = false
 
 player:applyLinearImpulse( 0.9 , 0 ,  player.x , player.y )
  end
 
 
 end
end



function touched2(event)

 sprites:play()
 sprites2:play()
 
 if ( event.phase=="began"  ) then
 
 if ( event.x < player.x )then
 
 esq = true
 
 if(esq) then  sprites2.isVisible=false
  sprites.isVisible=true
  
  end

 player:applyLinearImpulse( -0.9 , 0 ,  player.x , player.y )
  end
 
 if ( event.x > player.x )then
 
 if ( esq ) then  sprites2.isVisible=true
  sprites.isVisible=false  end

 esq = false
 
 player:applyLinearImpulse( 0.9 , 0 ,  player.x , player.y )
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

return enemy


end


function caiBola()

num = math.random(0 , 10)
if ( num < 8 ) then
 for i = 0, 3 do 
 local enemy = spawnEnemy()
 if(num < 5 ) then
 --enemy:applyLinearImpulse( 1, 0, enemy.x , enemy.y )
 enemy:applyLinearImpulse(0.3, 0.3, enemy.x , enemy.y )
 elseif( num >= 5 ) then
 --enemy:applyLinearImpulse( -1, 0, enemy.x , enemy.y )
 enemy:applyLinearImpulse( -0.3, 0.3, enemy.x , enemy.y )
 end
 
 table.insert( enemies , enemy) -- Display group da cena vai inserindo as bolas criadas
 
end
end
end
 --[[
  for i=1,#enemies, 1  do
   if ( enemies[i].y == borderBottom.y+20)then
  print(enemies[i]) end
       -- if ( enemies[i].y > borderBottom.y ) then  display.remove( enemies[i] ) end
    end

end
--]]



function update()

if ( player.x <= 0) then player.x = 0  end
if ( player.x >=  display.contentWidth ) then player.x = display.contentWidth * 2  end
sprites.x = player.x
sprites.y = player.y
sprites2.x = player.x
sprites2.y = player.y



--[[
for i=enemies.numChildren,1, -1 do 
   
 if(enemies[i].y >   
   
    
end 
--]]

 


end





timerLoop = timer.performWithDelay( 1 , update , -1 )
timerBalls = timer.performWithDelay( 800 , caiBola , -1 )
Runtime:addEventListener( "touch", touched2 )

--[[function scene:enterScene( event )

  group = self.view
  storyboard.removeScene("menu")
  timerLoop = timer.performWithDelay( 1 , update , -1 )
  
end
--]]


--[[
function scene:exitScene( event )

end



function scene:destroyScene( event )
   local group = self.view

   --code here only executes if the scene is being purged or removed
end

function scene:overlayEnded( event )
    local group = self.view
    --group.isVisible = true
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayEnded", scene )


--return scene
-]]