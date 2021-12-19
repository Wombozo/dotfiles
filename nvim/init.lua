-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'itchyny/lightline.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/dashboard-nvim'
  use 'terrortylor/nvim-comment'
  use 'dylanaraps/wal.vim'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-treesitter/nvim-treesitter'
  use 'max397574/better-escape.nvim'
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'liuchengxu/vista.vim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'ObserverOfTime/coloresque.vim'
-- Themes
  use 'NLKNguyen/papercolor-theme'
  use 'joshdick/onedark.vim'
  use 'jaredgorski/spacecamp'
  use 'ayu-theme/ayu-vim'
end)

require('options')
require('plugins')

vim.api.nvim_set_keymap('n', '<leader>h', ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", {})
vim.api.nvim_set_keymap('t','jk', '<C-\\><C-n>', {})

vim.api.nvim_set_keymap('n','<leader>sd', ':Vista!! <CR>', {})

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {})
