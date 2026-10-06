local user = "Tsukini"

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

function InsertHeaderCPP()
    local date = os.date("%d/%m/%Y")
    local file = vim.fn.expand("%:t")
    local filename = vim.fn.expand("%:t:r")
    local header = {
        "/**************************************************************\\",
        "Edition:",
        "##  @date " .. date .. " by @author " .. user,
        "",
        "File Name:",
        "##  @file " .. file,
        "",
        "File Description:",
        "##  You know, I don t think there are good or bad descriptions,",
        "##  for me, life is all about functions...",
        "\\**************************************************************/",
        "",
        "#include \"" .. filename .. ".hpp\""
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function InsertHeaderHHeader()
    local filename = vim.fn.expand("%:t")
    local year = os.date("%Y")
    local header = {
        "/*",
        "** EPITECH PROJECT, " .. year,
        "** " .. filename .. ".h",
        "** File description:",
        "** Header for the " .. filename,
        "*/",
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

function InsertHeaderHaskell()
    local filename = vim.fn.expand("%:t")
    local year = os.date("%Y")
    local header = {
        "{-",
        "-- EPITECH PROJECT, " .. year,
        "-- " .. filename,
        "-- File description:",
        "-- You know, I don t think there are good or bad descriptions,",
        "-- for me, life is all about functions...",
        "-}",
        "",
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end

function InsertHeader()
    local filename = vim.fn.expand("%:t")
    local ext = vim.fn.expand("%:e")  -- Obtient l'extension du fichier

    if ext == "py" then
        InsertHeaderPy()
    elseif ext == "c" or ext == "h" then
        InsertHeaderC()
    elseif ext == "cpp" or ext == "hpp" then
        InsertHeaderCPP()
    elseif filename == "Makefile" or filename == "makefile" or ext == "mk" then
        InsertHeaderMakefile()
    elseif ext == "hs" then
        InsertHeaderHaskell()
    else
        print("No Epitech header defined for this type of file: " .. ext)
    end
end

return function()
    InsertHeader()
end
