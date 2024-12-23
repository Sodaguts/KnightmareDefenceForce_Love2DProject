
-- use alt+L to run the project from vscode
-- alr chat, this is looking real messy 
require("worldgen")

function love.load()

    tree_img = love.graphics.newImage("images/sprites/tree_a.png")

    player = {}
    player.x = 100
    player.y = 100

    load()

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

    
    --love.graphics.circle("fill", player.x, player.y, 50)

    
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

    --grid trace
    if findElemByCoordinate(gridTrace.x,gridTrace.y) == true then
        love.graphics.setColor(1,1,1)
    else
        love.graphics.setColor(0.5,0.5,0.5)
    end
    --love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", gridTrace.x, gridTrace.y, 50,50)

end

function drawGrid()


    for it=1,gridSize,1 do
        love.graphics.setColor(1,1,1)
        love.graphics.draw(tree_img, gridTiles[it].x, gridTiles[it].y)
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
        --generateGrid(gridLength,gridWidth)
        --TODO
        --generatePath()
    end

    

end

function love.keypressed(key, scancode, isRepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == "right" then
        traceX = traceX+11
        if traceX > gridSize then
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
            traceX = gridSize
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
        -- traceIndex = traceIndex + 1
        -- traceElement = {}
        -- traceElement.x = gridTrace.x
        -- traceElement.y = gridTrace.y
        --tracePath[traceIndex] = traceElement -- basically use this same concept to generate an actual path in 
                                             -- the map
        pathPoint = pathPoint + 1
        if tracePath[pathPoint] == nil then
            pathPoint = 1
        end

        gridTrace.x = tracePath[pathPoint].x
        gridTrace.y = tracePath[pathPoint].y

    end

    if key == "r" then
        generatePath()
    end
end

-- for the ai moving along the path we can probably just loop through the path array and move each enemy after
-- a set period of time until they reach the end and then destroy that enemy (idk how to do that yet)