
-- use alt+L to run the project from vscode
-- alr chat, this is looking real messy 

function love.load()

    player = {}
    player.x = 100
    player.y = 100

    gridTiles = {}
    pathTiles = {}
    tracePath = {}

    gridSize = 0

    startPos = {}
    finPos = {}


    gridLength = 10
    gridWidth = 10

    traceIndex  = 0 -- index for the trace path
    gridTrace = {}

    traceX = 1
    traceY = 1


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


    -- draw path
    for i = 1, traceIndex, 1 do
        love.graphics.setColor(0,1,0)
        love.graphics.rectangle("fill",tracePath[i].x, tracePath[i].y,50 , 50)
    end

    --draw start/end
    love.graphics.setColor(0,0,1)
    love.graphics.rectangle("fill", gridTiles[startPos.x].x, gridTiles[startPos.y].y, 50,50)
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill", gridTiles[finPos.x].x, gridTiles[finPos.y].y, 50, 50)

end

function drawGrid()
    --love.graphics.setColor(0,0,1)
    -- it = 0
    -- for i=0,50,1 do
    --     it = it +1
    --     if pathTiles[it] ~= nil then
    --         love.graphics.setColor(0,0,1)
    --         love.graphics.rectangle("fill", gridTiles[pathTiles[it]].x, gridTiles[pathTiles[it]].y, 50,50)
    --         drawnValues[it] = pathTiles[it]
    --     end
    -- end
    -- for i = 1, 110, 1 do
    --     if findValueDrawn(i) == false then
    --         love.graphics.setColor(.8,0,1)
    --         love.graphics.rectangle("fill", gridTiles[i].x, gridTiles[i].y, 50,50)
    --     end
        
    -- end

    for it=1,gridSize,1 do
        love.graphics.setColor(.8,0,1)
        love.graphics.rectangle("line", gridTiles[it].x, gridTiles[it].y, 50,50)
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

    startPos.x = 1
    startPos.y = 10

    finPos.x = 110
    finPos.y = 1

    randDirX = 1
    randDirY = 1

    -- ok time for some actual path gen (locked in)

    while startPos.x ~= finPos.x and startPos.y ~= finPos.y do
        --choose a random direction to go to
        randX = math.random(1,5)
        if randX > 3 then
            randDirX = 11
        elseif randX < 3 then
            randDirX = -11
        else
            randDirX = 0
        end

        randY = math.random(1,5)
        if randY > 3 then
            randDirY = 1
        elseif randY < 3 then
            randDirY = -1
        else 
            randDirY = 0
        end

        -- increment startPos and add to the path [may want to use a copy of startPos since we'll need]
        -- the startPos to spawn enemies later
        break -- temp break to prevent my computer from crashing :')
    end

    traceIndex = traceIndex + 1
    newElemY = math.random(1,5)
    newElemX = math.random(1,5) +11
    test = {}
    test.x = gridTiles[newElemX].x
    test.y = gridTiles[newElemY].y
    tracePath[traceIndex] = test
    
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

    --generatePath(traceIndex)
    
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

    --test path making
    if key == "space" then
        --add to path array
        traceIndex = traceIndex + 1
        traceElement = {}
        traceElement.x = gridTrace.x
        traceElement.y = gridTrace.y
        tracePath[traceIndex] = traceElement -- basically use this same concept to generate an actual path in 
                                             -- the map
    end
end