function love.load()

--collision library stuff lol------
 wf = require 'windfield'
 world = wf.newWorld(0, 0)

 world:addCollisionClass('plr')
 world:addCollisionClass('proj')
 world:addCollisionClass('dummy')
 world:addCollisionClass('test_weapon')

 world:setQueryDebugDrawing(true)  
----------------------------------- 

--player properties------------

plr = {} 
plr.x = 100 
plr.y = 100 
plr.speed = 200 
plr.collider = world:newBSGRectangleCollider(100, 200, 40, 50, 10)
plr.collider:setFixedRotation(true)
plr.collider:setCollisionClass('plr')
plr.dir = "left"

-----------------------------------

--enemy properties-------------------------------------------
dummy = {} 
dummy.collider = world:newRectangleCollider(200, 200, 50, 50)
dummy.x = dummy.collider:getX() 
dummy.y = dummy.collider:getY() 
dummy.collider:setType('static')
dummy.collider:setCollisionClass('dummy')
dummy.hp = 20
-------------------------------------------------------------

--projectile properties--
 proj = {}
 proj.x = plr.x + 30  
 proj.y = plr.y 
 proj.rad = 10
-------------------------

--testing weapons for melee combat---------------------------------
test_weapon = {} 
test_weapon.range_x = 60
test_weapon.range_y = 60
test_weapon.damage = 10  
test_weapon.collider = world:newRectangleCollider(400, 400, 30, 20) 
test_weapon.collider:setCollisionClass('test_weapon')
test_weapon.equiped = false
-------------------------------------------------------------------

end 



function love.update(dt)


--melee table for flexability if i need to code switching the weapon--
--melee = {} 
--melee.range_x = nil 
--weapon.range_y = nil 
----------------------------------------------------------------------

--player's current position--------
px, py = plr.collider:getPosition() 
-----------------------------------

--so the enemy health is constantly updated duh--

plr.hp = 30
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

------------------------------------------------------- 


--update the world and set the collider velocites and position--
plr.collider:setLinearVelocity(vx, vy)

world:update(dt)

if dummy.hp < 1 then 
    dummy.collider:destroy()
end 

--equiping the test weapon---------------
if plr.collider:enter('test_weapon') then 
    test_weapon.equiped = true
    test_weapon.collider:destroy()
end 

-----------------------------------------



plr.x = plr.collider:getX() 
plr.y = plr.collider:getY() 


--------------------------------------------------------------------- 
end 



function love.draw() 

--does this even need explaining?--
world:draw()

if test_weapon.equiped == true then 
    love.graphics.print("true")
else 
    love.graphics.print("false")
end 

love.graphics.print(dummy.hp, 40, 0)
-----------------------------------


end 



function love.keypressed(key)

    if test_weapon.equiped == true and key == 'space' then 
            local melee_detect = world:queryCircleArea(px, py, test_weapon.range_x, {'dummy'})
            if #melee_detect > 0 then 
                dummy.hp = dummy.hp - test_weapon.damage 
            end 
        --end 
    end  
end
