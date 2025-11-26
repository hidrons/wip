function love.load()

--collision library stuff lol------
 wf = require 'windfield'
 world = wf.newWorld(0, 0)

 world:addCollisionClass('plr')

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

-----------------------------------


end 







function love.update(dt)

px, py = plr.collider:getPosition() 

spawn_proj = false  

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

 if spawn_proj == true then

      pvx = 0 
      pvy = 0

      pvx = proj.speed 
 end 

end 



function love.draw() 

--does this even need explaining?--
world:draw()
-----------------------------------


end 


function love.keypressed(key)

--projectile testing-------- 
 if key == 'space' then   
   spawn_proj = true
 end

 if spawn_proj == true then 
    --projectile properties----------------------------------------
    proj = {} 
    proj.x = px
    proj.y = py
    proj.speed = 130 

    if spawn_proj == true then 
        proj.collider = world:newCircleCollider(proj.x, proj.y, 10)
        proj.collider:setLinearVelocity(pvx, pvy)
    end
---------------------------------------------------------------
---------------------------- 
 end

end
