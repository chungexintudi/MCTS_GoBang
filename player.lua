M={}

--应该想办法实现一个读取用户输入再返回的函数read_input
--能修改引擎后再打包吗?
function M.take_action( current_state )
    
end

local function onMouseEvent( event )
    if event.type == "down" then
        print("click")    
    end
end

Runtime:addEventListener( "mouse", onMouseEvent )
return M
