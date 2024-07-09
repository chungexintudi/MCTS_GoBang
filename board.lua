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

function Board:clone()
    local bd=Board:new()
    for i =1,3,1 do
        for j =1,3,1 do
            bd.data[i][j] = self.data[i][j]     
        end
    end
    return bd
end


function Board:show()
    for i = 1,3,1 do    
        print( self.data[i][1], self.data[i][2],self.data[i][3] )
        print("\n")
    end
end

function Board:compare( other )
    for i =1,3,1 do
        for j =1,3,1 do
            if self.data[i][j] ~= other.data[i][j] then
                return false
            end
        end
    end
    return true
end

return Board
