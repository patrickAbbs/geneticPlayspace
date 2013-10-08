
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

 treasures = {}

 clouds = {}
end

function love.update(dt)
 heroColor = "green"
 for i,enemy in ipairs(enemies) do
    if hero.y < enemy.y+15 and hero.y > enemy.y-15 and hero.x < enemy.x+30 and hero.x > enemy.x-30 then
	  heroColor = "red"
	end
 end

 for i,enemy in ipairs(enemies) do
    enemy.x = enemy.x + enemy.speed*dt
	if enemy.x > hero.x and enemy.x < hero.x + 100 and hero.jumpingNow == false then
	  hero.jump()
	end
 end

 for i,treasure in ipairs(treasures) do
    treasure.x = treasure.x + treasure.speed*dt
 end

 for i,cloud in ipairs(clouds) do
    cloud.x = cloud.x + cloud.speed*dt
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
    enemy = {}
    enemy.x = 1000
    enemy.y = 450
	enemy.width = 30
	enemy.height = 15
    enemy.speed = -200
	table.insert(enemies, enemy)
 end

 if math.random() < .001 then
    treasure = {}
    treasure.x = 1000
    treasure.y = 450
	treasure.width = 20
	treasure.height = 15
    treasure.speed = -200
	table.insert(treasures, treasure)
 end

 if math.random() < .0005 then
   cloud = {}
   cloud.x = 1000
   cloud.y = math.random(350)
   cloud.width = math.random(55) + 35
   cloud.height = math.random(45) + 15
   cloud.speed = -50
   table.insert(clouds, cloud)
 end

end

function love.draw()
 -- let's draw some ground
 love.graphics.setColor(0,255,0,255)
 love.graphics.rectangle("fill", 0,465,800,150)

 --clouds
 love.graphics.setColor(20, 100, 200, 255)
 for i,cloud in ipairs(clouds) do
    love.graphics.rectangle("fill", cloud.x, cloud.y, cloud.width, cloud.height)
 end

 --treasures
 love.graphics.setColor(255, 215, 0, 255)
 for i,treasure in ipairs(treasures) do
    love.graphics.rectangle("fill", treasure.x, treasure.y, treasure.width, treasure.height)
 end

 -- let's draw our hero
 love.graphics.setColor(0, 255, 0, 255)
 if heroColor == "red" then
   love.graphics.setColor(255,0,0,255)
 end

 love.graphics.rectangle("fill", hero.x,hero.y, 30,15)

 --enemies
 love.graphics.setColor(255,0,0,255)
 for i,enemy in ipairs(enemies) do
    love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
 end
end


