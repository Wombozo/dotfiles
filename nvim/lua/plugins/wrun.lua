require'wrun'.setup({
  cache_dir = os.getenv( "HOME" ) .. '/.local/share/nvim/wrun',
  interpreter = '/usr/bin/bash',
  edit_method = '8split', -- 'edit' | 'tabedit' | 'split'| 'vsplit'
  term_settings = {
    exec_direction = 'float', -- 'vertical' | 'horizontal' | 'float'
    size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end, -- or hardcoded value
    exec_float_opts = {
      width = 100,
      height = 40,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }
})
