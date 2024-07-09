State={}

function State:new( player,board )
    local o = {}
    setmetatable(o, {__index=self})
    o.player = player
    o.board = board:clone()
    return o
end

function State:clone()
    local o = State:new(self.player,self.board)
    return o
end

--返回所有可以落子的位置
function State:get_available_actions()
    local available_act={}
    for i = 1,3,1 do    
        for j = 1,3,1 do
            if self.board.data[i][j] == 0 then
                local act = {i,j}
                table.insert( available_act,act )
            end
        end
    end
    return available_act
end
        
--返回:is_over, winner
function State:get_state_result()
    --print("get_state_result:")
    --self.board:show()
    --检测每一行
    for i = 1,3,1 do
        if self.board.data[i][1] == self.board.data[i][2] and self.board.data[i][1] == self.board.data[i][3] then
            if self.board.data[i][1] > 0 then
                return true,self.board.data[i][1]   
            end       
        end        
    end
    --检测每一列
    for i = 1,3,1 do
        if self.board.data[1][i] == self.board.data[2][i] and self.board.data[1][i] == self.board.data[3][i] then
            if self.board.data[1][i] > 0 then
                return true,self.board.data[1][i]       
            end
        end        
    end
    --检测斜角    
    if self.board.data[1][1] == self.board.data[2][2] and self.board.data[2][2] == self.board.data[3][3] then
        if self.board.data[1][1] > 0 then
            return true,self.board.data[1][1]
        end
    end
    if self.board.data[1][3] == self.board.data[2][2] and self.board.data[2][2] == self.board.data[3][1] then
        if self.board.data[1][3] > 0 then
            return true,self.board.data[1][3]
        end
    end
    --检测是否有空位
    local zero = 0
    for i = 1,3,1 do
        for j = 1,3,1 do
            if self.board.data[i][j] == 0 then
                zero = zero+1
            end
        end
    end
    --还有的动
    if zero > 0 then
        --print("还能动")
        return false,nil
    --平局
    else
        --print("平局")
        return true,nil
    end
end

 --根据动作返回一个新的状态
function State:get_next_state( action )
    local next_board = self.board:clone()
    next_board.data[action[1]][action[2]] = self.player
    next_player = self.player%2+1
    next_state = State:new(next_player, next_board)
    return next_state
end

--比较两个状态
function State:compare( other )
    if self.player == other.player and self.board:compare( other.board ) then
        return true
    else
        return false
    end    
end

return State
