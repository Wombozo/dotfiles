local M = { }

M.config = function()
  require("indent_blankline").setup {
    buftype_exclude = { "terminal", "prompt", "nofile" },
    filetype_exclude = { "dashboard", "help", "man", "lspinfo", "alpha", "neo-tree", "notify", "noice", "nofile" },
  }
end

M.use = { 'lukas-reineke/indent-blankline.nvim' }

return M
