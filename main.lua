
-- tutorial #1
-- the 3 golden love function, lua tables, keyboard input, draw circle

function love.load()
 hero = {} -- new table for the hero
 hero.x = 300    -- x,y coordinates of the hero
 hero.y = 450
 hero.speed = 100

 enemy = {}
 enemy.x = 400
 enemy.y = 450
 enemy.speed = 0
end

function love.update(dt)
 if love.keyboard.isDown("left") then
   hero.x = hero.x - hero.speed*dt
 elseif love.keyboard.isDown("right") then
   hero.x = hero.x + hero.speed*dt
 end
 if love.keyboard.isDown("down") then
   hero.y = hero.y + hero.speed*dt
 elseif love.keyboard.isDown("up") then
   hero.y = hero.y - hero.speed*dt
 end
 heroColor = "green"
 if hero.y < enemy.y+15 and hero.y > enemy.y-15 and hero.x < enemy.x+30 and hero.x > enemy.x-30 then
   heroColor = "red"
 end
end

function love.draw()
 -- let's draw some ground
 love.graphics.setColor(0,255,0,255)
 love.graphics.rectangle("fill", 0,465,800,150)

 -- let's draw our hero
 if heroColor == "red" then
   love.graphics.setColor(255,0,0,255)
 end
 --elseif heroColor == "red" then
 love.graphics.rectangle("fill", hero.x,hero.y, 30,15)

 --enemy
 love.graphics.setColor(255,0,0,255)
 love.graphics.rectangle("fill", enemy.x, enemy.y, 30,15)
end


