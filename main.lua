function love.load() 

--collision library stuff------- 

wf = require 'windfield'
world = wf.newWorld(0, 0) 

world:addCollisionClass('plr') 
world:addCollisionClass('enemy') 
world:addCollisionClass('item')

world:setQueryDebugDrawing(true) 
---------------------------------

--player properties---------------------------------------------
plr = {} 
plr.x = 100 
plr.y = 100 
plr.speed = 200 
plr.collider = world:newBSGRectangleCollider(20, 20, 30, 40, 10) 
plr.collider:setCollisionClass('plr') 
plr.collider:setFixedRotation(true)  
--------------------------------------------------------------- 

--enemy properties-----------------------------------------
enemy = {} 
enemy.x = 100 
enemy.y = 100 
enemy.collider = world:newRectangleCollider(100, 100, 40, 50) 
enemy.collider:setCollisionClass('enemy') 
enemy.collider:setType('static')  
-----------------------------------------------------------

--item stuff-----------------------------------------
item = {} 
item.collider = world:newCircleCollider(200, 300, 40)
item.collider:setType('static') 
----------------------------------------------------- 

ability = {} 

end 


function love.keypressed(key) 


 if key == 'space' then 
  local px, py = plr.collider:getPosition()
  
  if plr.dir == "left" then 
   px = px - 30
  elseif plr.dir == "right" then 
   px = px + 30 
  end 
  if plr.dir == "up" then 
   py = py - 30 
  elseif plr.dir == "down" then 
   py = py + 30 
  end 
   
  local colliders = world:queryCircleArea(px, py, 30, {'enemy'})
 
 if #colliders > 0 then
  enemy.collider:destroy()
  end 
 end

if key == 'f' then 
 if ability.fireball.aquired == true then 
  

end 


function love.update(dt) 

 ability.fireball.aquired = false

--collider velocites--
 local vx = 0 
 local vy = 0 
----------------------

--controls------------------------
 if love.keyboard.isDown("a") then 
  vx = -plr.speed 
  --direction------
   plr.dir = "left" 
  -----------------
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
 ---------------------------------------
 
 --set the collider velocity to vx & vy-
 plr.collider:setLinearVelocity(vx, vy) 
 --------------------------------------
 
 --collision library stuff---
 world:update(dt) 
 plr.x = plr.collider:getX() 
 plr.y = plr.collider:getY() 
 
 --enemy x and y lolz-----------
 enemy.x = enemy.collider:getX()
 enemy.y = enemy.collider:getY()
 -------------------------------

 ----------------------------
 
 
 --fireball---------------------
 
 if ability.fireball.aquired == true then 
  
  function shoot()
   
   fireball = {} 
   fireball.collider = world:newCircleCollider(plr.x, plr.y, 20)
   
   fvx = 0 
   fvy = 0 
   
   fireball.collider:setLinearVelocity(fvx, fvy)
   
  
  end 
 
 
 -------------------------------
end 



function love.draw() 

--does this even need explaination?--
 world:draw()
-------------------------------------

if ability.fireball.aquired == true then 
 love.graphics.print("aquired") 
else 
 love.graphics.print("not aquired") 
end 

end 




function item()

if plr.collider:enter('item') then 
 item.collider:destroy() 
 ability.fireball.aquired = true
end 

end 
