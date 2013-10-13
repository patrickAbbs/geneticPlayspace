function love.draw()

 drawObjects()
 printInfo()

end


function drawObjects()
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
 --enemies
 love.graphics.setColor(255,0,0,255)
 for i,enemy in ipairs(enemies) do
    love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.width, enemy.height)
 end
end

function printInfo()
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
 printY = 10
 for i, pastGeneration in ipairs(pastGenerations) do
   love.graphics.print("generation number: "..pastGeneration.generationNumber.. ", score: "..pastGeneration.averageScore..", enemy jump chance: "..pastGeneration.enemyJumpChanceAverage, 300, printY)
   printY = printY + 15
 end
end
