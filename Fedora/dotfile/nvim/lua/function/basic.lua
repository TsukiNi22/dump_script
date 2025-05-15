function InsertProtoPy()
    local proto = {
        "def ():",
        "    pass",
    }
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row, row, false, proto)
end

function InsertProtoC()
    local proto = {
        "int ()",
        "{",
        "    if ()",
        "        return err_prog(PTR_ERR, KO, ERR_INFO);",
        "    return OK;",
        "}",
    }
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row, row, false, proto)
end

function InsertProtoH()
    local proto = {
        "int (); // Error: KO",
}
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row, row, false, proto)
end

function InsertProto()
    local filename = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")  -- Obtient l'extension du fichier

    if ext == "py" then
        InsertProtoPy()
    elseif ext == "c" then
        InsertProtoC()
    elseif ext == "h" then
        InsertProtoH()
    else
        print("No Basic proto defined for this type of file: " .. ext)
    end
end

return function()
    InsertProto()
end
