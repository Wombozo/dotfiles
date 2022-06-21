local M = { }

M.config = function()
  require('nvim_comment').setup()
end


M.use = { 'terrortylor/nvim-comment' }

return M
