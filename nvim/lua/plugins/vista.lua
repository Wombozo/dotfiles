local M = { }

M.config = function()
  vim.cmd [[
    augroup VistaAutoclose
      autocmd!
      autocmd bufenter * if (winnr("$") == 1 && &filetype =~# 'vista') | q | endif
    augroup end
  ]]
end

M.use = { 'liuchengxu/vista.vim' }

return M
