M={}

function M.setFunc( func )
    Runtime:addEventListener( "mouse", func )
end

function M.trans(x,y)
    local cx = display.contentCenterX
    local cy = display.contentCenterY
    for i=0,2,1 do
        for j=0,2,1 do
            if 
            x >= cx-100+j*100-49 and
            x <= cx-100+j*100+49 and
            y >= cy-100+i*100-49 and
            y <= cy-100+i*100+49 then
                return {i+1,j+1}                    
            end
        end
    end
    return {-1,-1}
end

return M
