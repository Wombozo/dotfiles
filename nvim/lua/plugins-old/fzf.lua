local M = { }

M.config = function()
  require'lspfuzzy'.setup{}
end

M.use = {
  'ojroques/nvim-lspfuzzy',
  requires = {
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'}, -- to enable preview (optional)
  },
}

return M
