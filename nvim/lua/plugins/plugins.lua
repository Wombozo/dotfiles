local M = { }

require('plugins.packer-setup')

local plugins = {
  ['packer'] = {
    active = true,
    use = { 'wbthomason/packer.nvim' },
  },
  ['lspconfig'] = {
    active = true,
    use = { 'neovim/nvim-lspconfig' },
  },
  ['git'] = {
    active = true,
    use = { 'tpope/vim-fugitive', 'junegunn/gv.vim', 'airblade/vim-gitgutter' },
  },
  ['telescope'] = {
    active = true,
    use = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  },
  ['nvimtree'] = {
    active = true,
    use = { 'kyazdani42/nvim-tree.lua' },
  },
  ['cmp'] = {
    active = true,
    use = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
  },
  ['dashboard'] = {
    active = false,
    use = { 'glepnir/dashboard-nvim' },
  },
  ['alpha'] = {
    active = true,
    use = { 'goolord/alpha-nvim' },
  },
  ['term'] = {
    active = true,
    use = { 'akinsho/toggleterm.nvim' },
  },
  ['neoclip'] = {
    active = true,
    use = { 'AckslD/nvim-neoclip.lua', 'tami5/sqlite.lua' },
  },
  ['lightline'] = {
    active = false,
    use = { 'itchyny/lightline.vim' },
  },
  ['treesitter'] = {
    active = true,
    use = { 'nvim-treesitter/nvim-treesitter' },
  },
  ['comment'] = {
    active = true,
    use = { 'terrortylor/nvim-comment' },
  },
  ['vista'] = {
    active = true,
    use = { 'liuchengxu/vista.vim' },
  },
  ['wrun'] = {
    active = true,
    use = { 'wombozo/wrun' },
  },
  ['marks'] = {
    active = false,
    use = { 'chentoast/marks.nvim' },
  },
  ['catppuccin'] = {
    active = true,
    use = { 'catppuccin/nvim' },
  },
  ['zoxide'] = {
    active = true,
    use = { 'jvgrootveld/telescope-zoxide' },
  },
  ['betterescape'] = {
    active = true,
    use = { 'max397574/better-escape.nvim' },
  },
  ['hipairs'] = {
    active = false,
    use = { '' },
  },
  ['devicons'] = {
    active = true,
    use = { 'kyazdani42/nvim-web-devicons' },
  },
  ['tabline'] = {
    active = false,
    use = { 'kdheepak/tabline.nvim', },
  },
  ['lualine'] = {
    active = true,
    use = { 'hoob3rt/lualine.nvim', },
  },
  ['bufferline'] = {
    active = true,
    use = { 'akinsho/bufferline.nvim', },
  },
  ['barbar'] = {
    active = false,
    use = { 'romgrk/barbar.nvim' },
  },
  ['persistence'] = {
    active = true,
    use = { 'folke/persistence.nvim' },
  },
  ['indent-blankline']  = {
    active = true,
    use = { 'lukas-reineke/indent-blankline.nvim' },
  },
  ['scrollview'] = {
    active = true,
    use = { 'dstein64/nvim-scrollview' },
  },
  ['glow'] = {
    active = true,
    use = { 'ellisonleao/glow.nvim' },
  },
  ['hlslens'] = {
    active = true,
    use = { 'kevinhwang91/nvim-hlslens' },
  },
  ['themes'] = {
    active = true,
    use = {
      'NLKNguyen/papercolor-theme',
      'joshdick/onedark.vim',
      'jaredgorski/spacecamp',
      'ayu-theme/ayu-vim',
      'sainnhe/everforest',
      'savq/melange',
      'sjl/badwolf',
      'marciomazza/vim-brogrammer-theme',
      'uu59/vim-herokudoc-theme',
      'srcery-colors/srcery-vim',
    },
  },
}

M.get_unused = function()
  for key, value in pairs(plugins) do
    if value.active == false then
      print(key)
    end
  end
end

M.get_used = function()
  for key, value in pairs(plugins) do
    if value.active == true then
      print(key)
    end
  end
end

M.get_all = function()
  for key, _ in pairs(plugins) do
    print(key)
  end
end

M.plugins = plugins

return M
