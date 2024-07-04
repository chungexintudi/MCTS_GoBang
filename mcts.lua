M={}


function M.take_action( current_state )
    local i = math.random(0,2)       
    local j = math.random(0,2)    
    local action={i,j}
    return action
end

return M
