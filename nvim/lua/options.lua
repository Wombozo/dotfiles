local options = { }

vim.o.termguicolors = true

vim.cmd('silent! colorscheme ' .. os.getenv("VIM_THEME"))

-- SignColumn same as LineNr
vim.cmd('highlight! link SignColumn LineNr')

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Fold to indent
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false

--Set sign column
vim.o.signcolumn = 'auto'

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 10

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 4

vim.opt.listchars = {
  extends = ">",
  eol = "¬",
  tab = ">.",
  lead = ".",
  trail = "␣",
}
vim.opt.listchars.tab = ">"

-- Diff
-- vim.opt.diffopt = 'internal,filler,closeoff,vertical'
vim.opt.diffopt = 'filler,closeoff,vertical'
--Remap space as leader key
vim.g.mapleader = '\\'

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.opt.splitbelow = true

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.python_host_prog = '/usr/bin/python2'

return options;
