print(_VERSION)
math.randomseed(os.time())
local cx = display.contentCenterX
local cy = display.contentCenterY
    
local mainGroup = display.newGroup()

local function clear( group, i, j )
    local bkg = display.newRect( group, cx-100+j*100, cy-100+i*100, 98, 98 )
    bkg:setFillColor(1.0,1.0,1.0)
end

local function drawBkg( group )
    for i = 0,2,1 do
        for j = 0,2,1 do
            clear( group,i,j )
        end
    end
end


local function putCircle( group, i, j )
    local c = display.newCircle( group, cx-100+j*100, cy-100+i*100, 30 )
    c.strokeWidth=0.3
    c:setStrokeColor(1.0,0.2,0.2)
    c:setFillColor(255.0/255.0,165.0/255.0,0)
end

local function putRect( group, i, j )
    local rc = display.newRect( group, cx-100+j*100, cy-100+i*100, 60, 60 )
    rc:setFillColor(255.0/255.0,165.0/255.0,0)
end

drawBkg( mainGroup )
putCircle(mainGroup,0,0)
putRect(mainGroup,1,1)
putCircle(mainGroup,2,2)
