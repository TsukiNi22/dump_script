return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- The main branch doesn't support lazy-loading
    build = ":TSUpdate",
    config = function()
        -- Needs tree-sitter-cli + a C compiler (async, done once)
        require("nvim-treesitter").install({
            "c", "cpp", "python", "lua", "bash",
            "markdown", "make", "cmake", "json", "yaml",
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "python", "lua", "bash", "sh", "markdown", "make", "cmake", "json", "yaml" },
            callback = function(args)
                pcall(vim.treesitter.start, args.buf) -- Parser not installed yet -> default highlight
            end,
        })
    end,
}
