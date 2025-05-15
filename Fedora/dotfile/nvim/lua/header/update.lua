vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        local edition_line = nil
        local header_found = false

        for i, line in ipairs(lines) do
            if line:match("╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝") then
                header_found = true
            end
            if line:match("^Edition:") then
                edition_line = i
            end
        end

        if header_found and edition_line then
            local date = os.date("%d/%m/%Y")
            local user = "Tsukini"
            local new_line = "Edition:\n##  " .. date .. " by " .. user
            vim.api.nvim_buf_set_lines(bufnr, edition_line - 1, edition_line + 1, false, vim.split(new_line, "\n"))
        end
    end
})
