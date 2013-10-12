function newTurn(dt)
  createChanceAll()
  updateAll(dt)
end

function createChanceAll()
 if math.random() < .001 then
  createEnemy()
 end

 if math.random() < .001 then
  createTreasure()
 end

 if math.random() < .0005 then
  createCloud()
 end
end


function updateAll(dt)
 updateHero()
 updateEnemies(dt)
 updateTreasures(dt)
 updateClouds(dt)
end





function createEnemy()
 enemy = {}
 enemy.x = 800
 enemy.y = 450
 enemy.width = 30
 enemy.height = 15
 enemy.speed = -200
 enemy.perceived = false
 table.insert(enemies, enemy)
end

function createTreasure()
 treasure = {}
 treasure.x = 800
 treasure.y = 450
 treasure.width = 20
 treasure.height = 15
 treasure.speed = -200
 treasure.perceived = false
table.insert(treasures, treasure)
end

function createCloud()
 cloud = {}
 cloud.x = 800
 cloud.y = math.random(350)
 cloud.width = math.random(55) + 35
 cloud.height = math.random(45) + 15
 cloud.speed = -50
 table.insert(clouds, cloud)
end

function updateHero()
 for i,enemy in ipairs(enemies) do
	if enemy.x > hero.x and enemy.x < hero.x + hero.DNA.enemyObject.jump.distance[1] and enemy.perceived == false and hero.jumpingNow == false then
	  enemy.perceived = true
	  if math.random() < hero.DNA.enemyObject.jump.probability[1] then
	    hero.jump()
	  end
	end
 end

 for i,treasure in ipairs(treasures) do
	if treasure.x > hero.x and treasure.x < hero.x + hero.DNA.treasureObject.jump.distance[1] and treasure.perceived == false and hero.jumpingNow == false then
	  treasure.perceived = true
	  if math.random() < hero.DNA.treasureObject.jump.probability[1] then
	    hero.jump()
	  end
	end
 end

 if hero.jumpingNow == true then
  progressJump()
 end

end

function progressJump()
 hero.jumpSpeed = hero.jumpSpeed - hero.jumpDecay
 hero.move()
 if hero.y > 450 then
   hero.y = 450
   hero.jumpingNow = false
   hero.jumpSpeed = hero.initialJumpSpeed
 end
end

function updateEnemies(dt)
 for i,enemy in ipairs(enemies) do
    enemy.x = enemy.x + enemy.speed*dt
    if hero.y < enemy.y+15 and hero.y > enemy.y-15 and hero.x < enemy.x+30 and hero.x > enemy.x-30 then
	  herocolor = "red"
	  hero.health = hero.health - 1
	end
 end
end

function updateTreasures(dt)
 for i,treasure in ipairs(treasures) do
    treasure.x = treasure.x + treasure.speed*dt
	if hero.y < treasure.y+15 and hero.y > treasure.y-15 and hero.x < treasure.x+20 and hero.x > treasure.x-20 then
	  hero.points = hero.points + 1000
	  table.remove(treasures, i)
	end
 end
end

function updateClouds(dt)
 for i,cloud in ipairs(clouds) do
    cloud.x = cloud.x + cloud.speed*dt
 end
end
