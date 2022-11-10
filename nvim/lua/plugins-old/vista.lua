local M = { }

M.config = function()
  vim.cmd [[
    augroup VistaAutoClose
      autocmd!
      autocmd bufenter * if (winnr("$") == 1 && &filetype =~# 'vista') | q | endif
    augroup end
  ]]
  -- vim.cmd [[
  --   function OpenVista()
  --     let cw = win_getid(winnr())
  --     echomsg 'DEBUT'
  --     echomsg cw
  --     Vista
  --     echomsg 'ET PUIS'
  --     echomsg win_getid(winnr())
  --   endfunction
  --   augroup VistaAutoOpen
  --     autocmd!
  --     autocmd BufWinEnter *.c,*.h call OpenVista() 
  --   augroup end
  -- ]]
end

M.use = { 'liuchengxu/vista.vim' }

return M
