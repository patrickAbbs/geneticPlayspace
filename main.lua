
-- tutorial #1
-- the 3 golden love function, lua tables, keyboard input, draw circle

function love.load()
 hero = {} -- new table for the hero
 hero.x = 300    -- x,y coordinates of the hero
 hero.y = 450
 hero.jumpSpeed = .3
 hero.jumpNow = 0
 hero.jumpingNow = false
 function hero.jump()
   hero.y = hero.y - hero.jumpSpeed
   hero.jumpingNow = true
 end
 function hero.move()
   hero.y = hero.y - hero.jumpSpeed
 end

 enemies = {}

 enemy = {}
 enemy.x = 1000
 enemy.y = 450
 enemy.speed = -100
 table.insert(enemies, enemy)
end

function love.update(dt)
 heroColor = "green"
 for i,enemy in ipairs(enemies) do
    if hero.y < enemy.y+15 and hero.y > enemy.y-15 and hero.x < enemy.x+30 and hero.x > enemy.x-30 then
	  heroColor = "red"
	end
 end

 --enemy.x = enemy.x + enemy.speed*dt

 for i,enemy in ipairs(enemies) do
    enemy.x = enemy.x + enemy.speed*dt
 end

 if hero.jumpingNow == true then
    hero.jumpSpeed = hero.jumpSpeed - .001
    hero.move()
	if hero.y > 450 then
	  hero.y = 450
	  hero.jumpingNow = false
	  hero.jumpSpeed = .3
	end
 end

 if math.random() < .001 then
    if hero.jumpingNow == false then
      hero.jump()
	end
    enemy = {}
    enemy.x = 1000
    enemy.y = 450
    enemy.speed = -200
	table.insert(enemies, enemy)
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

 love.graphics.rectangle("fill", hero.x,hero.y, 30,15)

 --enemy
 love.graphics.setColor(255,0,0,255)
 love.graphics.rectangle("fill", enemy.x, enemy.y, 30,15)

 for i,v in ipairs(enemies) do
    love.graphics.rectangle("fill", v.x, v.y, 30, 15)
 end
end


