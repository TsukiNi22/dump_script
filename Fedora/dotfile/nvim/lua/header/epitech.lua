function InsertHeaderPy()
    local filename = vim.fn.expand("%:t")
    local year = os.date("%Y")
    local header = {
        "#!/bin/env python3",
        "##",
        "## EPITECH PROJECT, " .. year,
        "## " .. filename,
        "## File description:",
        "## You know, I don t think there are good or bad descriptions,",
        "## for me, life is all about functions...",
        "##",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function InsertHeaderC()
    local filename = vim.fn.expand("%:t")
    local year = os.date("%Y")
    local header = {
        "/*",
        "** EPITECH PROJECT, " .. year,
        "** " .. filename,
        "** File description:",
        "** You know, I don t think there are good or bad descriptions,",
        "** for me, life is all about functions...",
        "*/",
        "",
        "#include \"error.h\"",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function InsertHeaderH()
    local filename = vim.fn.expand("%:t:r")
    local filename_upper = string.upper(filename)
    local year = os.date("%Y")
    local header = {
        "/*",
        "** EPITECH PROJECT, " .. year,
        "** " .. filename .. ".h",
        "** File description:",
        "** Header for the " .. filename,
        "*/",
        "",
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
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function InsertHeaderMakefile()
    local filename = vim.fn.expand("%:t")
    local year = os.date("%Y")
    local header = {
        "##",
        "## EPITECH PROJECT, " .. year,
        "## " .. filename,
        "## File description:",
        "## You know, I don t think there are good or bad descriptions,",
        "## for me, life is all about functions...",
        "##",
        "",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function InsertHeader()
    local filename = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")  -- Obtient l'extension du fichier

    if ext == "py" then
        InsertHeaderPy()
    elseif ext == "c" then
        InsertHeaderC()
    elseif ext == "h" then
        InsertHeaderH()
    elseif filename == "Makefile" or filename == "makefile" or ext == "mk" then
        InsertHeaderMakefile()
    else
        print("No Epitech header defined for this type of file: " .. ext)
    end
end

return function()
    InsertHeader()
end
