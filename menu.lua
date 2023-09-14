local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require( "widget" )


-- Function to handle button events
local function starte( event )

    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
        storyboard.gotoScene( "game" )
        
    end
end


function scene:createScene( event )
   local group = self.view
   
  start = display.newImageRect("start_btn.png",80,35)
  start.anchorX = 0.5
  start.anchorY = 1
  start.x = display.contentCenterX
  start.y = display.contentCenterY 
  group:insert(start)
  start:addEventListener("touch", starte)


  
end

function scene:enterScene( event )
   local group = self.view
   

   --code here executes every time the scene is entered regardless
   --of it's creation state.
end

function scene:exitScene( event )
   local group = self.view

   --code here executes every time someone leaves the scene
end

function scene:destroyScene( event )
   local group = self.view

   --code here only executes if the scene is being purged or removed
end

function scene:overlayEnded( event )
    local group = self.view
end





scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayEnded", scene )

return scene


