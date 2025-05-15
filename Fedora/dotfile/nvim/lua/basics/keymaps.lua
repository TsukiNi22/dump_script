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
vim.keymap.set({'n', 'i'}, '<C-e>', '<cmd>Ex<CR>', opts)        --Go to file explorer
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd>w<CR>', opts)         --Save
vim.keymap.set({'n', 'i'}, '<C-q>', '<cmd>q<CR>', opts)         --Leave
vim.keymap.set({'n', 'i'}, '<C-x>', '<cmd>wq<CR>', opts)        --Save & Leave
vim.keymap.set({'n', 'i'}, '<C-z>', '<cmd>undo<CR>', opts)      --Undo
vim.keymap.set({'n', 'i'}, '<C-y>', '<cmd>redo<CR>', opts)      --Redo

-- Other
vim.keymap.set({'n', 'i'}, '<C-h>', require("header.choice"), opts)     -- Write header at the start of the file
vim.keymap.set({'n', 'i'}, '<C-f>', require("function.choice"), opts)  -- Write function proto at the curent position
