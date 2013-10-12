require "draw"
require "updates"


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
 heroCounter = 1

 heroes = {}
 initializeEverything(currentGeneration.number)
end

function love.update(dt)
 herocolor = "blue"
 hero.points = hero.points + 1

 newTurn(dt)

 if hero.health < 0 then
	table.insert(currentGeneration.heroes, hero)

	deathCounter = deathCounter + 1
	if deathCounter == 3 then
	  newGeneration()
	else
	hero = heroes[deathCounter]
	enemies = {}--so hack
	clouds = {}--so hack
	treasures = {}--so hack
	end
 end

end




function initializeEverything(generation)
 initializeHero(generation)
 initializeHero(generation)
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
 hero.health = 1
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

 table.insert(heroes, hero)

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
 heroes = {}
 initializeChildHero(generation)
 initializeChildHero(generation)
 initializeChildHero(generation)
 delayNewObject = false
 delayNewObjectTime = 0

 enemies = {}

 treasures = {}

 clouds = {}
end

function initializeChildHero(generation)
  hero = {}
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

  hero.generation = generation
  hero.DNA = {}
  hero.DNA = mutateDNA(bestHero.DNA, hero.DNA)

 function hero.jump()
   hero.y = hero.y - hero.jumpSpeed
   hero.jumpingNow = true
 end
 function hero.move()
   hero.y = hero.y - hero.jumpSpeed
 end
 table.insert(heroes, hero)
end

function newGeneration()
 bestScore = 0
 heroCounter = 0
 for i,hero in ipairs(currentGeneration.heroes) do
   heroScore = hero.points
   if heroScore > bestScore then
     bestHero = hero
	 bestScore = heroScore
   end
 end

 lastGenerationNumber = currentGeneration.number
 currentGeneration = {}
 currentGeneration.heroes = {}
 currentGeneration.number = lastGenerationNumber + 1

 deathCounter = 0
 initializeChildEverything(currentGeneration.number)
 currentGeneration.heroes = {}
end


function mutateDNA(baseDNA, newDNA)

  negativizeIt = math.random()
  flipper = 1.0000000
  if negativizeIt < .5 then
    flipper = -1.000000
  end
  newDNA.enemyObject = {}
  newDNA.enemyObject.jump = {}
  newDNA.enemyObject.jump.probability = {baseDNA.enemyObject.jump.probability[1] + (math.random() * baseDNA.enemyObject.jump.probability[2] * flipper), .05} --first is probability, second is child-inheritance variance

  negativizeIt = math.random()
  flipper = 1.0000000
  if negativizeIt < .5 then
    flipper = -1.000000
  end
  newDNA.enemyObject.jump.distance = {baseDNA.enemyObject.jump.distance[1] + (math.random() * baseDNA.enemyObject.jump.distance[2] * flipper), 5} --first is distance, second is child-inheritance variance

  newDNA.treasureObject = {}
  newDNA.treasureObject.jump = {}
  newDNA.treasureObject.jump.probability = {baseDNA.treasureObject.jump.probability[1], .05}
  newDNA.treasureObject.jump.distance = {baseDNA.treasureObject.jump.distance[1], 5}
  --newDNA = {}
  --love.graphics.setColor(0, 255, 255, 255)
  --for i, objectType in pairs(baseDNA) do
    --i = {}
  --  newDNA.i = {}
	--love.graphics.print(i, 100, 100)
	--debug.debug()
    --love.timer.sleep(10)
 --   for j, action in pairs(objectType) do
--	  newDNA.i.j = {}
	  --for k, actionProbability in ipairs(action) do
	  --  flipper = 1
	  --negativizeIt = math.random()
	  --if negativizeIt < .5 then
	  --  flipper = -1
	  --end
	  --newDNA.i.j.k = actionProbability
	  --end
      --love.graphics.print(action.probability, 100, 25)
	  --love.timer.sleep(10)
--	  newDNA.i.j.probability = action.probability
--	end
  --end


  --love.graphics.print(newDNA.i.j.probability[1], 100, 25)
  --love.graphics.print(newDNA.enemyObject.jump.probability[1], 100, 25)
  --love.timer.sleep(10)


  return newDNA
end

