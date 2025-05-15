require 'basics.options'
require 'basics.keymaps'

vim.g.mapleader = " "

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath})
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    --require 'themes.nord',
    require 'themes.rose-pine',
    --require 'themes.oldworld',
    --require 'themes.catppuccin',
    --require 'themes.tokyodark',
    --require 'themes.cyberdream',
    --require 'themes.oxocarbon',
    --require 'themes.deepwhite',

    require 'plugins.auto-completion',
    require 'plugins.neotree',
    require 'plugins.header',

})

-- Update the date of xartania header
require 'header.update'
