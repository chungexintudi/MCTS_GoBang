State={}

function State:new( player,board )
    local o = {}
    setmetatable(o, {__index=self})
    o.player = player
    o.board = board
    return o
end

function State:clone()
    local o={}
    o.player = self.player
    o.board = self.board:clone()
    return o
end
        
--is_over, winner
function State:get_state_result()
        

    return false,1
end

function State:get_available_actions()

end

function State:get_next_state( action )

end

return State
