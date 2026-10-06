-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {silent = true})

local opts = {noremap = true, silent = true}

-- Basic -> leader
vim.keymap.set('n', '<leader>s', '<cmd>so<CR>', opts)       --Source
vim.keymap.set('n', '<leader>e', '<cmd>Ex<CR>', opts)       --Go to file explorer
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', opts)        --Save
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', opts)        --Leave
vim.keymap.set('n', '<leader>W', '<cmd>wq<CR>', opts)       --Save & Leave

-- Basic -> Ctrl
vim.keymap.set({'n', 'i'}, '<C-e>', '<cmd>Ex<CR>', opts)            --Go to file explorer
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd>w<CR>', opts)             --Save
vim.keymap.set({'n', 'i'}, '<C-q>', '<cmd>q<CR>', opts)             --Leave
vim.keymap.set({'n', 'i'}, '<C-x>', '<cmd>wq<CR>', opts)            --Save & Leave
vim.keymap.set({'n', 'i'}, '<C-z>', '<cmd>undo<CR>', opts)          --Undo
vim.keymap.set({'n', 'i'}, '<C-y>', '<cmd>redo<CR>', opts)          --Redo
vim.keymap.set({'n', 'i'}, '<C-S-Right>', '<cmd>next<CR>', opts)    --Next file
vim.keymap.set({'n', 'i'}, '<C-S-Left>', '<cmd>prev<CR>', opts)     --Previous file
vim.keymap.set({'n', 'v'}, '<C-l>', '$', opts)                      --End of line (normal/visual)
vim.keymap.set('i', '<C-l>', '<C-o>$', opts)                        --End of line (insert)
vim.keymap.set({'n', 'v'}, 'L', '^', opts)                          --Start of line (normal/visual, overrides default L = bottom of screen)

-- Horizontal splits -> Ctrl+Shift+PageUp/PageDown
vim.keymap.set({'n', 'i'}, '<C-S-PageUp>',   '<cmd>botright split<CR>',   opts)  --Horizontal split, new window at top
vim.keymap.set({'n', 'i'}, '<C-S-PageDown>', '<cmd>topleft split<CR>', opts)   --Horizontal split, new window at bottom

-- Window switching -> Ctrl+Shift+arrows
vim.keymap.set({'n', 'i'}, '<C-S-Up>',    '<cmd>wincmd k<CR>', opts)    --Switch to window above
vim.keymap.set({'n', 'i'}, '<C-S-Down>',  '<cmd>wincmd j<CR>', opts)    --Switch to window below

-- Other
vim.keymap.set({'n', 'i'}, '<C-h>', require("header.choice"), opts)     -- Write header at the start of the file
vim.keymap.set({'n', 'i'}, '<C-f>', require("function.choice"), opts)   -- Write function proto at the curent position
local ts_enabled = true
local function toggle_treesitter()
    if ts_enabled then
        vim.treesitter.stop()
        ts_enabled = false
        print("Treesitter OFF")
    else
        vim.treesitter.start()
        ts_enabled = true
        print("Treesitter ON")
    end
end
vim.keymap.set("n", "<C-p>", toggle_treesitter, { noremap = true, silent = true }) -- Start & Stop the advenced color higlight
