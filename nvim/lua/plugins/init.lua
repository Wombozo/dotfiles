require('plugins.packer-setup')

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'itchyny/lightline.vim'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/dashboard-nvim'
  use 'terrortylor/nvim-comment'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-treesitter/nvim-treesitter'
  use 'max397574/better-escape.nvim'
  use 'romgrk/barbar.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'liuchengxu/vista.vim'
  use 'editorconfig/editorconfig-vim'
  use "akinsho/toggleterm.nvim"
  use 'L3MON4D3/LuaSnip'
  use { "AckslD/nvim-neoclip.lua", requires = {{'nvim-telescope/telescope.nvim'}, 'tami5/sqlite.lua', module = 'sqlite'}}
  use 'kevinhwang91/nvim-hlslens'
  use 'dstein64/nvim-scrollview'
-- cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
-- Themes
  use 'NLKNguyen/papercolor-theme'
  use 'joshdick/onedark.vim'
  use 'jaredgorski/spacecamp'
  use 'ayu-theme/ayu-vim'
end)

require('plugins.telescope')
require('plugins.nvimtree')
require('plugins.lspconfig')
require('plugins.cmp')
require('plugins.dashboard')
require('plugins.term')
require('plugins.neoclip')
require('plugins.lightline')
require('plugins.treesitter')
require('plugins.comment')
