local options = { }
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

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[ silent! colorscheme PaperColor ]]
options.lightline_theme='PaperColor'

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 4

--vim.opt.listchars = { extends = ">", eol = "¬", trail = "~", space = "␣", tab = ">." }
vim.opt.listchars = {
  extends = ">",
  eol = "¬",
  tab = ">.",
  lead = ".",
  trail = "␣",
}
vim.opt.listchars.tab = ">"

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

return options;
