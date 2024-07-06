M={}


function M.take_action( board )
    local i = -1
    local j = -1
    
    for k = 1,100,1 do
        local i = math.random(0,2)       
        local j = math.random(0,2) 
        
        if board.data[i+1][j+1] == 0 then
            local action={i,j}
            return action
        end
    end

    return {-1,-1}
end

return M
