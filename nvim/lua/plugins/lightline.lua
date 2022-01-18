local o = require('options')

vim.g.lightline = {
  colorscheme = o.lightline_theme,
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}