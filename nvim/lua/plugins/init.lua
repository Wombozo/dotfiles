require('plugins.packer-setup')

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use {'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- use 'itchyny/lightline.vim'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/dashboard-nvim'
  use 'terrortylor/nvim-comment'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-treesitter/nvim-treesitter'
  use 'max397574/better-escape.nvim'
  -- use 'romgrk/barbar.nvim'
  use 'hoob3rt/lualine.nvim'
  -- use {'kdheepak/tabline.nvim', requires = { {'hoob3rt/lualine.nvim'}, {'kyazdani42/nvim-web-devicons'} }}
  -- use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use {'akinsho/bufferline.nvim'}
  use 'kyazdani42/nvim-web-devicons'
  use 'liuchengxu/vista.vim'
  use 'editorconfig/editorconfig-vim'
  use 'akinsho/toggleterm.nvim'
  use 'L3MON4D3/LuaSnip'
  use {'AckslD/nvim-neoclip.lua', requires = {{'nvim-telescope/telescope.nvim'}, 'tami5/sqlite.lua', module = 'sqlite'}}
  use 'kevinhwang91/nvim-hlslens'
  use 'dstein64/nvim-scrollview'
  use {'sudormrfbin/cheatsheet.nvim', requires = { {'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
  use 'ellisonleao/glow.nvim'
  use 'chentau/marks.nvim'
  use 'jvgrootveld/telescope-zoxide'
  -- use 'anuvyklack/pretty-fold.nvim'

-- cmp
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

-- Themes
  use 'NLKNguyen/papercolor-theme'
  use 'joshdick/onedark.vim'
  use 'jaredgorski/spacecamp'
  use 'ayu-theme/ayu-vim'
  use 'sainnhe/everforest'
  use 'savq/melange'
  use 'sjl/badwolf'
  use 'catppuccin/nvim'
  use 'marciomazza/vim-brogrammer-theme'
  use 'uu59/vim-herokudoc-theme'
  -- use {'844196/lightline-badwolf.vim', requires = {{'itchyny/lightline.vim'}}}
  use {'srcery-colors/srcery-vim', as = 'srcery'}

-- My own
  use {'wombozo/wrun', requires = {{'akinsho/toggleterm.nvim'}}}
end)

require'plugins.telescope'
require'plugins.nvimtree'
require'plugins.lspconfig'
require'plugins.cmp'
require'plugins.dashboard'
require'plugins.term'
require'plugins.neoclip'
-- require'plugins.lightline'
require'plugins.treesitter'
require'plugins.comment'
require'plugins.vista'
require'plugins.wrun'
require'plugins.marks'
-- require'plugins.pretty-fold'
require'plugins.catppuccin'
require'plugins.zoxide'
require'plugins.betterescape'
-- require'plugins.hipairs'
-- require'plugins.tabline'
require'plugins.lualine'
require'plugins.bufferline'
