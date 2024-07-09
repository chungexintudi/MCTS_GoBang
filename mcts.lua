local Node = require 'node'
MCTS={}

function MCTS:new()
    local o = {}
    setmetatable(o, {__index=self})
    o.root = nil
    o.current_node = nil
    return o
end

function MCTS:simulation_policy()
    local current_node = self.current_node
    local is_over = false
    local winner = nil

    while current_node:is_full_expand() 
    do
        is_over, winner = current_node.state:get_state_result()
        if is_over then
            return current_node
        end
        current_node = current_node:select_func( 1.4 )
    end
                   
    return current_node:expand_func()
end

function MCTS:simulation( count )
    for i = 1,count,1 do
        local leaf_node = self:simulation_policy()
        local winner = leaf_node:rollout_func()
        leaf_node:update_func(winner)
    end
end

function MCTS:take_action( current_state )
    --[[
    local i = -1
    local j = -1
    
    for k = 1,100,1 do
        local i = math.random(1,3)       
        local j = math.random(1,3) 
        
        if current_state.board.data[i][j] == 0 then
            local action={i,j}
            return action
        end
    end
    return {-1,-1}
    ]]
    if self.root == nil then
        self.root = Node:new( current_state, nil, nil )
        self.current_node = self.root        
    else
        for i=1,#self.current_node.children,1 do
            local child_node = self.current_node.children[i]
            if child_node.state:compare( current_state ) then
                print("找到了子节点")
                self.current_node = child_node
                break
            end        
        end
    end    
    self:simulation(200)
    local next_node = self.current_node:select_func(0.0)
    self.current_node = next_node 
    return self.current_node.action
end

return MCTS
