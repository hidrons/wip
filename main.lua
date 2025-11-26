function love.load()

--collision library stuff lol------
 wf = require 'windfield'
 world = wf.newWorld(0, 0)

 world:addCollisionClass('plr')
 world:addCollisionClass('enemy')

 world:setQueryDebugDrawing(true)  
----------------------------------- 

--player properties----------------

plr = {} 
plr.x = 100 
plr.y = 100 
plr.speed = 200 
plr.collider = world:newBSGRectangleCollider(200, 200, 40, 50, 10)
plr.collider:setFixedRotation(true)
plr.collider:setCollisionClass('plr')

px, py = plr.collider:getPosition() 
-----------------------------------



end 



function love.update(dt)

--velocities for the player's collider-- 
 vx = 0
 vy = 0 
---------------------------------------- 

--player controls, direction etc-----------------------

if love.keyboard.isDown("a") then 
    vx = -plr.speed 
     plr.dir = "left"

elseif love.keyboard.isDown("d") then 
    vx = plr.speed 
     plr.dir = "right"
end 

if love.keyboard.isDown("w") then 
    vy = -plr.speed 
     plr.dir = "up" 

elseif love.keyboard.isDown("s") then 
    vy = plr.speed 
     plr.dir = "down" 
end 

--------------------------------------------------------
--update the world and set the collider velocites and position--
plr.collider:setLinearVelocity(vx, vy)

world:update(dt)
plr.x = plr.collider:getX() 
plr.y = plr.collider:getY() 
----------------------------------------------------------------
end 



function love.draw() 

--does this even need explaining?--
world:draw()
-----------------------------------


end 


function love.keypressed(key)


end