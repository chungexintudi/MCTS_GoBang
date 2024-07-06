local player = require 'player'
local ai = require 'mcts'
local Board = require 'board'

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


local board = Board:new()
drawBkg( mainGroup )


--注意,绘制从0开始计数,数组从1开始计数
local function onMouseEvent( event )
    if event.type == "down" then
        print("click",event.x,event.y)    
        local pos1 = player.trans( event.x,event.y )
        --玩家下棋
        if pos1[1] ~= -1 and pos1[2] ~= -1 then
            put1(mainGroup,pos1[1],pos1[2])
            board.data[pos1[1]+1][pos1[2]+1] = 1
        end 
        --AI下棋
        local pos2 = ai.take_action( board )
        if pos2[1] ~= -1 and pos2[2] ~= -1 then
            put2(mainGroup,pos2[1],pos2[2])
            board.data[pos2[1]+1][pos2[2]+1] = 2
        end
        --判定胜负
        
        --打印棋盘
    end
end

player.setFunc( onMouseEvent )
