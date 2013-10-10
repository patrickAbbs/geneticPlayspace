
function love.load()
 backgroundColor = {}
 backgroundColor.red = math.random(255)
 backgroundColor.green = math.random(255)
 backgroundColor.blue = math.random(255)
 backgroundColor.otherThing = math.random(255)
 currentGeneration = {}
 currentGeneration.heroes = {}
 currentGeneration.number = 1
 deathCounter = 0

 initializeEverything(currentGeneration.number)
end

function love.update(dt)
 herocolor = "blue"
 hero.points = hero.points + 1

 updateHero()

 updateEnemies(dt)

 updateTreasures(dt)

 updateClouds(dt)

 if math.random() < .001 then
  createEnemy()
 end

 if math.random() < .001 then
  createTreasure()
 end

 if math.random() < .0005 then
  createCloud()
 end

 if hero.jumpingNow == true then
  progressJump()
 end

end

function love.draw()
 --let's draw some BACKground.. haha... puns. jk lol
 love.graphics.setColor(backgroundColor.red, backgroundColor.green, backgroundColor.blue, backgroundColor.otherThing)
 love.graphics.rectangle("fill", 0, 0, 1000, 1000)

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
 love.graphics.setColor(0, 0, 255, 255)
 if herocolor == "red" then
   love.graphics.setColor(255,0,0,255)
 end


 love.graphics.rectangle("fill", hero.x,hero.y, 30,15)
 love.graphics.print("health: ".. hero.health, 10, 10)
 love.graphics.setColor(0, 255, 255, 255)
 love.graphics.print("points: ".. hero.points, 10, 25)
 love.graphics.print("generation: ".. hero.generation, 10, 40)
 love.graphics.print("hero number: ".. deathCounter, 10, 55)
 love.graphics.print("enemy jump chance: ".. hero.DNA.enemyObject.jump.probability[1], 10, 70)
 love.graphics.print("enemy jump distance: ".. hero.DNA.enemyObject.jump.distance[1], 10, 85)
 love.graphics.print("treasure jump chance: ".. hero.DNA.treasureObject.jump.probability[1], 10, 100)
 love.graphics.print("treasure jump distance: ".. hero.DNA.treasureObject.jump.distance[1], 10, 115)
 love.graphics.print("death counter: ".. deathCounter, 10, 130)
 printY = 145
 for i,fallenHero in ipairs(currentGeneration.heroes) do
    love.graphics.print("potential parent "..i.." points ".. fallenHero.points, 10, printY)
	printY = printY + 15
 end

 --enemies
 love.graphics.setColor(255,0,0,255)
 for i,enemy in ipairs(enemies) do
    love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
 end

 if hero.health < 0 then
	table.insert(currentGeneration.heroes, hero)

	deathCounter = deathCounter + 1
	if deathCounter == 3 then
	  newGeneration()
	else
	  initializeEverything(hero.generation)
	end
 end
end




--side functions

function progressJump()
 hero.jumpSpeed = hero.jumpSpeed - hero.jumpDecay
 hero.move()
 if hero.y > 450 then
   hero.y = 450
   hero.jumpingNow = false
   hero.jumpSpeed = hero.initialJumpSpeed
 end
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


function initializeEverything(generation)

 initializeHero(generation)
 delayNewObject = false
 delayNewObjectTime = 0


 enemies = {}

 treasures = {}

 clouds = {}
end

function initializeHero(generation)
 hero = {} -- new table for the hero
 hero.generation = generation

 hero.x = 300    -- x,y coordinates of the hero
 hero.y = 450
 hero.health = 100
 hero.points = 0
 herocolor = "blue"
 hero.jumpSpeed = .6
 hero.initialJumpSpeed = .6
 hero.jumpDecay = .005
 hero.jumpNow = 0
 hero.jumpingNow = false

 function hero.jump()
   hero.y = hero.y - hero.jumpSpeed
   hero.jumpingNow = true
 end
 function hero.move()
   hero.y = hero.y - hero.jumpSpeed
 end

 hero = initializeDNA(hero)

 return hero
end

function initializeDNA(hero)
  hero.DNA = {}

  hero.DNA.enemyObject = {}
  hero.DNA.enemyObject.jump = {}
  hero.DNA.enemyObject.jump.probability = {math.random(), .05} --first is probability, second is child-inheritance variance
  hero.DNA.enemyObject.jump.distance = {math.random(80) + 20, 5} --first is distance, second is child-inheritance variance

  hero.DNA.treasureObject = {}
  hero.DNA.treasureObject.jump = {}
  hero.DNA.treasureObject.jump.probability = {math.random(), .05}
  hero.DNA.treasureObject.jump.distance = {math.random(80) + 20, 5}

  return hero
end

function initializeChildEverything(generation)
 initializeChildHero(generation)
 delayNewObject = false
 delayNewObjectTime = 0

 enemies = {}

 treasures = {}

 clouds = {}
end

function initializeChildHero(generation)
  hero = {}

  hero.x = 300    -- x,y coordinates of the hero
  hero.y = 450
  hero.health = 100
  hero.points = 0
  herocolor = "blue"
  hero.jumpSpeed = .6
  hero.initialJumpSpeed = .6
  hero.jumpDecay = .005
  hero.jumpNow = 0
  hero.jumpingNow = false

  hero.generation = generation
  hero.DNA = {}

  hero.DNA.enemyObject = {}
  hero.DNA.enemyObject.jump = {}
  hero.DNA.enemyObject.jump.probability = {bestHero.DNA.enemyObject.jump.probability[1], .05} --first is probability, second is child-inheritance variance
  hero.DNA.enemyObject.jump.distance = {bestHero.DNA.enemyObject.jump.distance[1] + 20, 5} --first is distance, second is child-inheritance variance

  hero.DNA.treasureObject = {}
  hero.DNA.treasureObject.jump = {}
  hero.DNA.treasureObject.jump.probability = {bestHero.DNA.treasureObject.jump.probability[1], .05}
  hero.DNA.treasureObject.jump.distance = {bestHero.DNA.treasureObject.jump.distance[1] + 20, 5}

 function hero.jump()
   hero.y = hero.y - hero.jumpSpeed
   hero.jumpingNow = true
 end
 function hero.move()
   hero.y = hero.y - hero.jumpSpeed
 end
end

function newGeneration()
 --backgroundColor = {}
 --backgroundColor.red = 255--math.random(255)
 --backgroundColor.green = 0--math.random(255)
 --backgroundColor.blue = 0--math.random(255)
 --backgroundColor.otherThing = math.random(255)
 bestScore = 0
 for i,hero in ipairs(currentGeneration.heroes) do
   heroScore = hero.points
   if heroScore > bestScore then
     bestHero = hero
	 bestScore = heroScore
   end
 end

 lastGenerationNumber = currentGeneration.number
 --currentGeneration = {}
 --currentGeneration.heroes = {}
 --currentGeneration.number = lastGenerationNumber + 1

 deathCounter = 0
 initializeChildEverything(lastGenerationNumber + 1)
 currentGeneration = {}
 currentGeneration.heroes = {}
end

