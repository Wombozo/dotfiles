local M = { }

M.config = function()
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true, -- false will disable the whole extension
      use_languagetree = true,
    },
  }
end

M.use = { 'nvim-treesitter/nvim-treesitter' }

return M
