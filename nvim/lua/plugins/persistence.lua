local M = { }

M.config = function()
  require'persistence'.setup()
end

M.use = { 'folke/persistence.nvim' }

return M
