local player = require 'player'
local MCTS = require 'mcts'
local Board = require 'board'
local State = require 'state'

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
    putCircle(group,i-1,j-1,{1,69.0/255.0,0})
end

local function put2(group,i,j)
    putCircle(group,i-1,j-1,{65/255,105/255,225/255})
end

local function run_step( game_state, pos )
    --print("run_step:player=",game_state.player,",pos=",pos[1],",",pos[2])
    --game_state.board:show()

    if pos[1] ~= -1 and pos[2] ~= -1 then
        if game_state.board.data[pos[1]][pos[2]] == 0 then
            if game_state.player == 1 then
                put1(mainGroup,pos[1],pos[2])
            else
                put2(mainGroup,pos[1],pos[2])
            end
            game_state.board.data[pos[1]][pos[2]] = game_state.player
        end
    end 

end

--state.player,1代表人,2代表AI
local state = State:new( 1, Board:new() )
local mcts = MCTS:new()
drawBkg( mainGroup )
local is_over = false
local winner = nil

--注意,绘制从0开始计数,数组从1开始计数
local function onMouseEvent( event )
    if event.type == "down" and is_over == false then
        --玩家下棋
        local pos1 = player.trans( event.x,event.y )
        if pos1[1] == -1 or pos1[2] == -1 then
            return
        end
        print("Player:",pos1[1],",",pos1[2])
        run_step( state, pos1 )
        state.player = state.player%2+1                        

        --判定胜负
        is_over,winner = state:get_state_result()
        print("当前胜负:",is_over,winner)
        state.board:show()

        if is_over then 
            print("It's over")
            return
        end 
    
        --AI下棋
        local pos2 = mcts:take_action( state )
        if pos2[1] == -1 or pos2[2] == -1 then
            print("AI error:",pos2[1],",",pos2[2])
            return
        end
        print("AI:",pos2[1],",",pos2[2])
        run_step( state, pos2 )
        state.player = state.player%2+1                        

        --判定胜负
        is_over,winner = state:get_state_result()
        print("当前胜负:",is_over,winner)
        state.board:show()
    end
end

player.setFunc( onMouseEvent )
