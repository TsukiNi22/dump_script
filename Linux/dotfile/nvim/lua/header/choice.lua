return function()
    vim.ui.input({
        prompt = "Choice an header (x = Xartania, e = Epitech): ",
        default = "",
    },
    function(input)
        if input == "x" then
            -- Xartania header
            require("header.xartania")()
        elseif input == "e" then
            -- Epitech header
            require("header.epitech")()
        else
            print("This header does not exist!")
        end
    end)
end
