function love.load()

--collision library stuff lol------
 wf = require 'windfield'
 world = wf.newWorld(0, 0)

 world:addCollisionClass('plr')
 world:addCollisionClass('proj')
 world:addCollisionClass('dummy')

 world:setQueryDebugDrawing(true)  
----------------------------------- 

--player properties------------

plr = {} 
plr.x = 100 
plr.y = 100 
plr.speed = 200 
plr.collider = world:newBSGRectangleCollider(200, 200, 40, 50, 10)
plr.collider:setFixedRotation(true)
plr.collider:setCollisionClass('plr')
plr.dir = "left"
-----------------------------------

--enemy properties-------------------------------------------
enemy = {} 
enemy.collider = world:newRectangleCollider(200, 200, 50, 50)
enemy.x = enemy.collider:getX() 
enemy.y = enemy.collider:getY() 
enemy.collider:setType('static')
enemy.collider:setCollisionClass('dummy')
-------------------------------------------------------------

end 



function love.update(dt)

px, py = plr.collider:getPosition() 

--so the enemy health is constantly updated duh--
enemy.health = 60
-------------------------------------------------

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



--projectile config--------------------------------------------------
function shoot() 

    proj = {}
    proj.x = plr.x + 30  
    proj.y = plr.y
    proj.rad = 10 


    --projectile direction----------------------
    if plr.dir == "left" then 
        proj.collider = world:newCircleCollider(proj.x - 60, proj.y, proj.rad)
        proj.collider:setLinearVelocity(-300, 0)
        proj.collider:setCollisionClass('proj')

    elseif plr.dir == "right" then 
        proj.collider = world:newCircleCollider(proj.x + 1, proj.y, proj.rad)
        proj.collider:setLinearVelocity(300, 0)
        proj.collider:setCollisionClass('proj')
    end 

    if plr.dir == "up" then 
        proj.collider = world:newCircleCollider(proj.x - 30, proj.y - 30, proj.rad)
        proj.collider:setLinearVelocity(0, -300)
        proj.collider:setCollisionClass('proj')

    elseif plr.dir == "down" then 
        proj.collider = world:newCircleCollider(proj.x - 30, proj.y + 30, proj.rad)
        proj.collider:setLinearVelocity(0, 300)
        proj.collider:setCollisionClass('proj')
    end 
    --------------------------------------------- 

    --simple collision detection for projectiles and enemies--
    if proj.collider:enter('dummy') then 
        enemy.collider:destroy()
    end  


    -----------------------------------------------------------
end
--------------------------------------------------------------------- 


end 



function love.draw() 

--does this even need explaining?--
world:draw()
-----------------------------------


end 



function love.keypressed(key)

 if key == 'space' then 
    shoot() 
 end 

end
