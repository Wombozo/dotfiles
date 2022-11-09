local M = { }

M.config = function()
  require'which-key'.setup{
    hide_statusline = false,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
    default_mode = 'n',
  }
end

M.use = { "folke/which-key.nvim" }


return M
