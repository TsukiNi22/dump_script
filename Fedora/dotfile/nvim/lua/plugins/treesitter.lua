return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "c", "cpp", "python", "lua", "bash",
            "markdown", "make", "cmake", "json", "yaml",
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "python", "lua", "bash", "sh", "markdown", "cmake", "json", "yaml" },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
