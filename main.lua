local player = require 'player'
local ai = require 'mcts'

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
    local desk = display.newRect( group, cx, cy, 640, 480 )
    desk:setFillColor(250.0/255.0,235.0/255.0,215.0/255.0)

    for i = 0,2,1 do
        for j = 0,2,1 do
            clear( group,i,j )
        end
    end
end


local function putCircle( group, i, j, color )
    local c = display.newCircle( group, cx-100+j*100, cy-100+i*100, 30 )
    c.strokeWidth=0.3
    c:setStrokeColor(1.0,0.2,0.2)
    c:setFillColor(color[1],color[2],color[3])
end

local function put1(group,i,j)
    putCircle(group,i,j,{1,69.0/255.0,0})
end

local function put2(group,i,j)
    putCircle(group,i,j,{65/255,105/255,225/255})
end


drawBkg( mainGroup )
--put1(mainGroup,0,0)
--put2(mainGroup,1,1)
--put1(mainGroup,2,2)

local state = {}
local action = {}
action = ai.take_action( state )
print("action=",action[1],action[2])


