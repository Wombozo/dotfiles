local M = { }

M.config = function()
  require'marks'.setup {
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  }
end

M.use = { 'chentoast/marks.nvim' }

return M
