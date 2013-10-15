require "draw"
require "updates"


function love.load()
 backgroundColor = {}
 backgroundColor.red = math.random(255)
 backgroundColor.green = math.random(255)
 backgroundColor.blue = math.random(255)
 backgroundColor.otherThing = math.random(255)
 currentGeneration = {}
 pastGenerations = {}
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
	if deathCounter == 10 then
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
 initializeHero(generation)
 initializeHero(generation)
 initializeHero(generation)
 initializeHero(generation)
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
 hero.health = 400
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
 initializeChildHero(generation)
 initializeChildHero(generation)
 initializeChildHero(generation)
 initializeChildHero(generation)
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
  hero.health = 400
  hero.points = 0
  herocolor = "blue"
  hero.jumpSpeed = .6
  hero.initialJumpSpeed = .6
  hero.jumpDecay = .005
  hero.jumpNow = 0
  hero.jumpingNow = false

  hero.generation = generation

  hero.DNA = mutateDNA(bestHero.DNA)

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
 pastGenerations[currentGeneration.number] = {}
 pastGenerations[currentGeneration.number].generationNumber = currentGeneration.number
 currentGenerationScore = 0
 currentGenerationCount = 0
 currentGenerationEnemyJumpChance = 0 --hack.  should probably be general 'get-all-the-object-type' sort of thing.  whatevs will figure out later
 currentGenerationEnemyJumpCount = 0 --hack.  see above
 for i,hero in ipairs(currentGeneration.heroes) do
   heroScore = hero.points

   currentGenerationScore = currentGenerationScore + hero.points
   currentGenerationCount = currentGenerationCount + 1

   currentGenerationEnemyJumpChance = currentGenerationEnemyJumpChance + hero.DNA.enemyObject.jump.probability[1]
   currentGenerationEnemyJumpCount = currentGenerationEnemyJumpCount + 1

   if heroScore > bestScore then
     bestHero = hero
	 bestScore = heroScore
   end
 end
 pastGenerations[currentGeneration.number].averageScore = currentGenerationScore / currentGenerationCount
 pastGenerations[currentGeneration.number].enemyJumpChanceAverage = currentGenerationEnemyJumpChance / currentGenerationEnemyJumpCount

 lastGenerationNumber = currentGeneration.number
 currentGeneration = {}
 currentGeneration.heroes = {}
 currentGeneration.number = lastGenerationNumber + 1

 deathCounter = 0
 initializeChildEverything(currentGeneration.number)
 currentGeneration.heroes = {}
end


function mutateDNA(baseDNA)
  newDNA = {}
  for i, objectType in pairs(baseDNA) do
    newDNA[i] = {}
    for j, action in pairs(objectType) do
	  newDNA[i][j] = {}
	  for k, actionProbability in pairs(action) do
	    flipper = 1
	    negativizeIt = math.random()
	    if negativizeIt < .5 then
	      flipper = -1
	    end
	    newDNA[i][j][k] = {}
	    mutationMutation = math.random()
	    mutationAmount = actionProbability[2] * mutationMutation * flipper
	    newDNA[i][j][k][1] = actionProbability[1] + mutationAmount
	    newDNA[i][j][k][2] = actionProbability[2] * (mutationMutation + .5)
	  end
	end
  end
  return newDNA
end

