
-- use alt+L to run the project from vscode

function love.load()
    player = {}
    player.x = 100
    player.y = 100

    gridTiles = {}

    gridLength = 10
    gridWidth = 10

    generateGrid(gridLength,gridWidth)

    pathTiles = {}
    randIt = 0
    for i=0,100,1 do
        randIt = math.random(100)
        for j=0,i,1 do
            if pathTiles[j] ~= randIt then
                table.insert(pathTiles,randIt)
                break
            end
        end
    end

    drawnValues = {}

end

function love.update(dt)
    getInput()
end

function love.draw()

    drawGrid()

    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill", player.x, player.y, 50)

    
end

function drawGrid()
    --love.graphics.setColor(0,0,1)
    it = 0
    for i=0,50,1 do
        it = it +1
        if pathTiles[it] ~= nil then
            love.graphics.setColor(0,1,0)
            love.graphics.rectangle("fill", gridTiles[pathTiles[it]].x, gridTiles[pathTiles[it]].y, 50,50)
            table.insert(drawnValues, pathTiles[it])
        end
    end
    for i = 1, 100, 1 do
        if findValueDrawn(i) == false then
            love.graphics.setColor(0,0,1)
            love.graphics.rectangle("fill", gridTiles[i].x, gridTiles[i].y, 50,50)
        end
        
    end
end

function findValueDrawn(value)
    for i=1,100,1 do
        if drawnValues[i] == value then
            return true
        end
    end
    return false
end

function generateGrid(length, width)
    -- use this to generate the grid on game start or to regenerate it later for (new waves) etc.
    -- RULES: should have a start and end goal (for a path to be generated)
    -- generate tiles that can be interacted with and tiles that cannot be interacted with (path tiles and start and end)
    -- the end goal will always be the middle top cuz thats where the place ur defending is
    -- throw an error if the grid is less than 3x3 ig

    -- actual grid generation
    for i=0, length, 1 do
        for j=0, width, 1 do
            element = {}
            element.x = i*50 + 10
            element.y = j*50 + 10
            table.insert(gridTiles,element)
        end
    end
end

function getInput()
    if love.keyboard.isDown("right") then
        player.x = player.x + 10
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - 10
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - 10
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + 10
    end

    if love.keyboard.isDown("r") then
        generateGrid(gridLength,gridWidth)
    end
end