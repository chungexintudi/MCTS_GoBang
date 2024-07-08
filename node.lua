local State = require 'state'

Node={}

function Node:new( state, pos, parent)
    local o = {}
    setmetatable(o, {__index=self})
    o.state = state:clone()
    o.untried_actions = board:get_available_actions()
    o.parent=parent
    o.children={}
    o.Q=0
    o.N=0
    o.pos=pos
    return o
end
    
function Node:weight_func(c_param)
    if self.N != 0 then
        --这里使用了-self.Q 因为子节点的收益代表的是对手的收益
        w = -self.Q / self.N + c_param * math.sqrt(2 * math.log(self.parent.N) / self.N)
    else
        w = 0.0
    return w
end

function Node:select_func( c_param )
    local max_w = -1
    local max_child = nil
    for i = 1,#self.children,do
        local w = self.children[i]:weight_func( c_param )
        if w > max_w then
            max_w = w
            max_child = self.children[i]
        end
    end
    return max_child
end

function Node:expand_func()
    local action = self.untried_actions[0]
    table.remove( self.untried_actions, 0 )
    local current_player = self.state.player
    local next_board = self.state.board:clone()
    next_board[action[1]][action[2]] = current_player
    local next_player = current_player%2+1
    local state = State:new( next_player,next_board )
    local child_node = Node:new(state,action,self)
    table.insert( self.children,child_node )

    return child_node
end

function Node:is_full_expand()
    return #self.untried_actions == 0
end

function Node:is_root_node()
    return self.parent ~= nil
end

function Node:rollout_func()
    local current_state = self.state:clone()

    while(true)
    do
        is_over, winner = current_state:get_state_result()
        if is_over then
            break
        end
        available_actions = current_state:get_available_actions()
        action = Node:get_random_action(available_actions)
        current_state = current_state:get_next_state(action)
    end
    return winner

end

function Node:update_func(winner)
    self.N += 1
    local op = self.state.player%2+1

    if winner == self.state.player then
        self.Q += 1
    elseif winner == op then
        self.Q -= 1
    end

    if self.is_root_node() then
        self.parent.update_func(winner)
    end
end


return Node
