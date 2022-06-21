local M = { }
M.config = function()
  vim.g.hiPairs_jl_matchPair = {term='underline,bold',cterm='underline,bold',ctermfg='0',ctermbg='180',gui='underline,bold',guifg='Black',guibg='#D3B17D'}
end

M.use = { 'Yggdroot/hiPairs' }

return M
