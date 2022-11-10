local M = { }

M.config = function()
  require'lualine'.setup {
    options = {
      theme = 'auto' -- o.line_theme
    }
  }
end

M.use = { 'hoob3rt/lualine.nvim' }

return M
