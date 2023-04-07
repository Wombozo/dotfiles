local options = { }

vim.o.termguicolors = true

-- vim.cmd('silent! colorscheme ' .. os.getenv("VIM_THEME"))
local cs_augroup = vim.api.nvim_create_augroup('ColorSchemeSave', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = cs_augroup,
    callback = function()
        vim.loop.fs_open(os.getenv'HOME' .. '/.config/nvim/plugin/colorscheme.lua', "w", 432, function(_, fd)
            vim.loop.fs_write(fd, "vim.cmd('silent! colorscheme " .. vim.g.colors_name .. "')", nil, function()
                vim.loop.fs_close(fd)
            end)
        end)
    end
})


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

--Session
vim.o.sessionoptions = 'blank,buffers,folds,help,tabpages,winsize,globals,terminal'
vim.o.viewoptions = 'folds,cursor'

-- keep fold
vim.cmd[[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END]]

vim.o.expandtab = true
vim.o.shiftwidth = 4
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

-- tabs
vim.g.guitablabel='%f'

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

-- Scrolloff
vim.o.scrolloff = 8;

-- Hide cursorline for inactive windows
vim.cmd[[
    augroup CursorLineOnlyInActiveWindow
      autocmd!
      autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
      autocmd WinLeave * setlocal nocursorline
    augroup END
]]

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.python_host_prog = '/usr/bin/python2'


return options;
