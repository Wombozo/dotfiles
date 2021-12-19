require('plugins.telescope')
require('plugins.nvimtree')
require('plugins.lspconfig')
require('plugins.bufferline')
require('plugins.cmp')
require('plugins.dashboard')

-- Set statusbar
vim.g.lightline = {
  colorscheme = 'ayu',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

-- Blankline
require("indent_blankline").setup {
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "dashboard",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
   }

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = true,
  },
}

require("better_escape").setup()
