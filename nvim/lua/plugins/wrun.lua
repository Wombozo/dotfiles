require'wrun'.setup({
  cache_dir = os.getenv( "HOME" ) .. '/.local/share/nvim/wrun',
  interpreter = '/usr/bin/bash',
  edit_method = '12split', -- 'edit' | 'tabedit' | 'split'| 'vsplit'
  term_settings = {
    -- exec_direction = 'float', -- 'vertical' | 'horizontal' | 'float'
    exec_direction = 'horizontal', -- 'vertical' | 'horizontal' | 'float'
    size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end, -- or hardcoded value
    exec_float_opts = {
      width = 160,
      height = 50,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }
})
