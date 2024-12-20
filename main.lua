
-- use alt+L to run the project from vscode

function love.load()

    player = {}
    player.x = 100
    player.y = 100

    gridTiles = {}
    pathTiles = {}

    gridSize = 0



    gridLength = 10
    gridWidth = 10

    generateGrid(gridLength,gridWidth)
    generatePath()


    randIt = 0
    for i=1,100,1 do
        randIt = math.random(100)
        for j=1,i,1 do
            if pathTiles[j] ~= randIt then
                table.insert(pathTiles,randIt)
                break
            end
        end
    end

    drawnValues = {}

    gridTrace = {}
    traceIndex  = 1
    traceX = 1
    traceY = 1
    gridTrace.x = gridTiles[traceX].x
    gridTrace.y = gridTiles[traceY].y

end

function love.update(dt)
    getInput()
end

function love.draw()

    drawGrid()

    love.graphics.setColor(1,1,1)
    --love.graphics.circle("fill", player.x, player.y, 50)

    love.graphics.rectangle("fill", gridTrace.x, gridTrace.y, 50,50)

    
end

function drawGrid()
    --love.graphics.setColor(0,0,1)
    it = 0
    for i=0,50,1 do
        it = it +1
        if pathTiles[it] ~= nil then
            love.graphics.setColor(0,0,1)
            love.graphics.rectangle("fill", gridTiles[pathTiles[it]].x, gridTiles[pathTiles[it]].y, 50,50)
            drawnValues[it] = pathTiles[it]
        end
    end
    for i = 1, 110, 1 do
        if findValueDrawn(i) == false then
            love.graphics.setColor(.8,0,1)
            love.graphics.rectangle("fill", gridTiles[i].x, gridTiles[i].y, 50,50)
        end
        
    end
    -- for i = 1,110,1 do
    --     love.graphics.setColor(0.8,0,1)
    --     love.graphics.rectangle("line", gridTiles[i].x, gridTiles[i].y, 50,50)
    -- end

    -- -- draw path based on elements in finalPath

    -- for j = 1,gridSize,1 do
    --     love.graphics.setColor(0,0,1)
    --     love.graphics.rectangle("fill", gridTiles[j].x, gridTiles[j].y, 50,50)
    -- end

    
    
end


function generatePath()
    -- generate path
    it = 0
    for i=1,100,1 do
        it = it+1
        randIt = math.random(100)
        for j=1,i,1 do
            if pathTiles[j] ~= randIt then
                pathTiles[it] = randIt
                break
            end
        end
    end

    -- determines direction
    
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
    it = 0
    for i=0, length, 1 do
        for j=0, width, 1 do
            it = it+1
            element = {}
            element.x = i*50 + 10
            element.y = j*50 + 10
            gridTiles[it] = element
            gridSize = gridSize + 1
        end
    end

    generatePath()
    
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

function love.keypressed(key, scancode, isRepeat)
    if key == "escape" then
        love.event.quit()
    end

    -- if key == "z" then
    --     traceIndex = traceIndex+1
    --     if traceIndex > gridSize-11 then
    --         traceIndex = 1
    --     end
    --     gridTrace.x = gridTiles[traceIndex].x
    --     gridTrace.y = gridTiles[traceIndex].y
    --     traceX = traceIndex
    --     traceY = traceIndex
    -- end

    if key == "right" then
        traceX = traceX+11
        if traceX > gridSize-11 then
            --traceIndex = 1
            traceX = 1
        end
        gridTrace.x = gridTiles[traceX].x
        gridTrace.y = gridTiles[traceY].y
    end

    if key == "left" then
        traceX = traceX-11
        if traceX < 1 then
            --traceIndex = 1
            traceX = gridSize-11
        end
        gridTrace.x = gridTiles[traceX].x
        gridTrace.y = gridTiles[traceY].y
    end

    if key == "up" then
        traceY = traceY-1
        if traceY < 1 then
            traceY = 11
        end
        gridTrace.x = gridTiles[traceX].x
        gridTrace.y = gridTiles[traceY].y
    end

    if key == "down" then
        traceY = traceY+1
        if traceY > 11 then
            traceY = 1
        end
        gridTrace.x = gridTiles[traceX].x
        gridTrace.y = gridTiles[traceY].y
    end
end