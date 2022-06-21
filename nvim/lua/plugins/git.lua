local M = { }
M.config = function()
  vim.g.gitgutter_sign_priority = 5
end

M.use = { 'tpope/vim-fugitive', 'junegunn/gv.vim', 'airblade/vim-gitgutter' }

return M
