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
    local filename = vim.fn.expand("%:t:r")
    local filename_upper = string.upper(filename)
    local year = os.date("%Y")
    local proto = {
        "#ifndef " .. filename_upper .. "_H",
        "    #define " .. filename_upper .. "_H",
        "",
        "    //----------------------------------------------------------------//",
        "    /* INCLUDE */",
        "",
        "    /* type */",
        "    #include <stdbool.h>",
        "",
        "    //----------------------------------------------------------------//",
        "    /* DEFINE */",
        "",
        "    /* sample */",
        "    #define SAMPLE 0",
        "",
        "//----------------------------------------------------------------//",
        "/* PROTOTYPE */",
        "",
        "/* " .. filename .. " */",
        "void sample(void); // Error: none",
        "",
        "#endif /* " .. filename_upper .. "_H */",
    }
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row, row, false, proto)
end
 
function InsertProtoCPP()
    local filename = vim.fn.expand("%:t:r")
    local proto = {
        "void " .. filename .. "::()",
        "{",
        "   /* Nothing */",
        "}",
    }
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row, row, false, proto)
end

function InsertProtoHPP()
    local filename = vim.fn.expand("%:t:r")
    local filename_upper = string.upper(filename)
    local year = os.date("%Y")
    local proto = {
        "#ifndef " .. filename_upper .. "_H",
        "    #define " .. filename_upper .. "_H",
        "",
        "    //----------------------------------------------------------------//",
        "    /* INCLUDE */",
        "",
        "    /* type */",
        "    #include <iostream>",
        "",
        "    //----------------------------------------------------------------//",
        "    /* DEFINE */",
        "",
        "    /* sample */",
        "    #define SAMPLE 0",
        "",
        "//----------------------------------------------------------------//",
        "/* CLASS */",
        "",
        "class " .. filename .. " {",
        "    private:",
        "        /* Nothing */",
        "",
        "    public:",
        "        // ---------- Pre-Function -------- //",
        "",
        "        // ------------ Function ---------- //",
        "",
        "        // ------------ Operator ---------- //",
        "        " .. filename ..  "& operator=(const " .. filename .. "& other) = delete;",
        "        " .. filename ..  "& operator=(" .. filename .. "&& other) = delete;",
        "",
        "        // ---------- Constructor --------- //",
        "        " .. filename .. "() = default;",
        "        " .. filename .. "(const " .. filename .. "& other) = delete;",
        "        " .. filename .. "(" .. filename .. "&& other) = delete;",
        "",
        "        // ----------- Destructor --------- //",
        "        ~" .. filename .. "() = default;",
        "};",
        "",
        "#endif /* " .. filename_upper .. "_H */",
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
    elseif ext == "cpp" then
        InsertProtoCPP()
    elseif ext == "hpp" then
        InsertProtoHPP()
    else
        print("No Basic proto defined for this type of file: " .. ext)
    end
end

return function()
    InsertProto()
end
