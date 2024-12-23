--! file: worldgen
-- world generation functions and stuff here
-- clean up main


function load()
    gridTiles = {}
    pathTiles = {} -- deprecated I think
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


    --gridTrace.x = gridTiles[traceX].x
    --gridTrace.y = gridTiles[traceY].y

end






function generatePath()

    for k in ipairs(tracePath) do
        tracePath[k] = nil
    end
    -- may want to use the vector to the end position to help determine direction instead of being totally random
    traceIndex = 0
    --pathMax = 1000
    pathPoint = 0

    startPos.x = 1
    startPos.y = 10

    finPos.x = 110
    finPos.y = 1

    randDirX = 1
    randDirY = 1

    wander = {}
    wander.x = startPos.x+11
    wander.y = startPos.y+1
    -- ok time for some actual path gen (locked in)

    while wander.x ~= finPos.x or wander.y ~= finPos.y+1 do
        --choose a random direction to go in
        -- if pathMax <= 0 then
        --     break
        -- end

        if traceIndex == 0 then
            randDirX = 1
            randDirY = 0
        else
            randXY = math.random(1,5)
            if randXY > 3 then
                randX = math.random(1,5)
                if randX > 3 then
                    randDirX = 11
                    randDirY = 0
                elseif randX < 3 then
                    randDirX = -11
                    randDirY = 0
                else
                    randDirX = 0
                    randDirY = 0
                end
            elseif randXY < 3 then
                randY = math.random(1,5)
                if randY > 3 then
                    randDirY = 1
                    randDirX = 0
                elseif randY < 3 then
                    randDirY = -1
                    randDirX = 0
                else 
                    randDirY = 0
                    randDirX = 0
                end
            else
                randDirX = 0
                randDirY = 0
            end
        end

        

        --move in that direction
        if randDirX ~= 0 or randDirY ~= 0 then
            wander.x = wander.x + randDirX
            wander.y = wander.y + randDirY

            --check to see if in bounds (move back if not)
            if wander.x > gridSize-11 then
                wander.x = gridSize-11
            elseif wander.x < 22 then
                wander.x = 22
            end

            if wander.y > 10 then
                wander.y = 10
            elseif wander.y < 2 then
                wander.y = 2
            end

            --TODO: check to see if elem already in array
            elem = {}
            elem.x = gridTiles[wander.x].x
            elem.y = gridTiles[wander.y].y
            if traceIndex == 0 then
                traceIndex = traceIndex + 1
                tracePath[traceIndex] = elem
                --pathMax = pathMax - 1
            else
                if table.contains(tracePath,elem) ~= true then
                    traceIndex = traceIndex + 1
                    tracePath[traceIndex] = elem
                    --pathMax = pathMax - 1
                end
            end
        end
    end
    
end

function table.contains(table,element)
    for i,value in pairs(table) do
        if value == element then
            return true
        else
            return false
        end
    end
end


function findValueDrawn(value)
    for i=1,110,1 do
        if drawnValues[i] == nil then
            return false
        end

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

-- use this to pass the in an X and Y position
-- will return true or false based on whether or not that position is in the path
function findElemByCoordinate(x,y)
    elem = {}
    elem.x = x
    elem.y = y
    for i=1,#tracePath do
        current = {}
        current.x = tracePath[i].x
        current.y = tracePath[i].y
        if current.x == elem.x and current.y == elem.y then
            return true
        end
    end
    return false
end
