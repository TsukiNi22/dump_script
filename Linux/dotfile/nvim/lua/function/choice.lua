return function()
    vim.ui.input({
        prompt = "Choice an function proto (b = Basic, e = Epitech): ",
        default = "",
    },
    function(input)
        if input == "b" then
            -- Basic proto
            require("function.basic")()
        elseif input == "e" then
            -- Epitech proto
            require("function.epitech")()
        else
            print("This proto does not exist!")
        end
    end)
end
