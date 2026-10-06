vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        local edition_line = nil
        local header_found = false
        local repeated_quotes = string.rep('"', 63)

        for i, line in ipairs(lines) do
            if line == "/**************************************************************\\" or line == "@>************************************************************<@" or line == "#**************************************************************#" or line == repeated_quotes then
                header_found = true
            end
            if line:match("^Edition:") then
                edition_line = i
            end
        end

        if header_found and edition_line then
            local ext = vim.fn.expand("%:e")  -- Obtient l'extension du fichier
            local date = os.date("%d/%m/%Y")
            local user = "Tsukini"
            local new_line = "Edition:\n##  Error"
            if ext == "cpp" or ext == "hpp" then
                new_line = "Edition:\n##  @date " .. date .. " by @author " .. user
            else
                new_line = "Edition:\n##  " .. date .. " by " .. user
            end

            vim.api.nvim_buf_set_lines(bufnr, edition_line - 1, edition_line + 1, false, vim.split(new_line, "\n"))
        end
    end
})
