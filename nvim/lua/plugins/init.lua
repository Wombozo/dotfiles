require('plugins.telescope')
require('plugins.nvimtree')
require('plugins.lspconfig')
require('plugins.barbar')
require('plugins.cmp')
require('plugins.dashboard')
require('plugins.term')
require('plugins.neoclip')

-- Set statusbar
vim.g.lightline = {
  colorscheme = 'ayu',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = true,
  },
}

-- Better escape
require("better_escape").setup()

-- Comments
require('nvim_comment').setup()
vim.api.nvim_set_keymap('n', '<C-_>', ':CommentToggle <CR>', {})
vim.api.nvim_set_keymap('v', '<C-_>', ':CommentToggle <CR>', {})

-- Vista
vim.api.nvim_set_keymap('n','<leader>sd', ':Vista!! <CR>', {})
