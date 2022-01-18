vim.cmd [[
  augroup VistaAutoclose
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && &filetype =~# 'vista') | q | endif
  augroup end
]]

