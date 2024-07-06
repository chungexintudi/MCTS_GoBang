Node={}

function Node:new( board, pos, parent)
    local o = {}
    setmetatable(o, {__index=self})
    o.board = board:clone()
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
        --tip： 这里使用了-self.Q 因为子节点的收益代表的是对手的收益
        w = -self.Q / self.N + c_param * math.sqrt(2 * math.log(self.parent.N) / self.N)
    else
        w = 0.0
    return w
end

function Node:select_func()

end

function Node:expand_func()

end

function Node:rollout_func()

end

function Node:update_func()

end

return Node
