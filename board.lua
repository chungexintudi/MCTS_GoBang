Board={}

function Board:new()
    local o = {}
    setmetatable(o, {__index=self})
    
    local board={}
    for i =1,3,1 do
        board[i]={}
        for j =1,3,1 do
            board[i][j] = 0        
        end
    end
    
    o.data = board
    return o
end

function Board.clone( _bd )
    local bd=Board:new()
    for i =1,3,1 do
        for j =1,3,1 do
            bd.data[i][j] = _bd.data[i][j]     
        end
    end
    return bd
end

function Board:get_available_actions()

end
  
function Board:get_state_result()

end

function Board:show()

end

return Board
