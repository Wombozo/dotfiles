local M = {}

-- Ensure highlights stay transparent across colorscheme changes
local function apply_transparent_background()
  local groups = {
    "LineNr",
    "SignColumn",
    "VertSplit",
    "Normal",
    "NonText",
    "NormalNC",
  }

  for _, group in ipairs(groups) do
    vim.cmd(("highlight %s guibg=NONE ctermbg=NONE"):format(group))
  end

  vim.cmd("highlight! link SignColumn LineNr")
end

local function setup_colorscheme_preferences()
  local background = vim.env.VIM_BACKGROUND
  if background == "light" or background == "dark" then
    vim.o.background = background
  end

  apply_transparent_background()

  local group = vim.api.nvim_create_augroup("ColorschemeOverrides", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    pattern = "*",
    callback = apply_transparent_background,
  })
end

local function apply_core_options()
  local opt = vim.opt
  local g = vim.g

  opt.termguicolors = true
  opt.swapfile = false
  opt.inccommand = "nosplit"
  opt.hlsearch = true
  opt.hidden = true
  opt.mouse = "a"
  opt.breakindent = true
  opt.foldmethod = "indent"
  opt.foldenable = false
  opt.signcolumn = "auto"
  opt.undofile = true
  opt.ignorecase = true
  opt.smartcase = true
  opt.updatetime = 10
  opt.sessionoptions = { "blank", "buffers", "folds", "help", "tabpages", "winsize", "globals", "terminal" }
  opt.viewoptions = { "folds", "cursor" }
  opt.number = true
  opt.relativenumber = false
  opt.expandtab = true
  opt.shiftwidth = 4
  opt.smartindent = true
  opt.tabstop = 4
  opt.listchars = {
    extends = ">",
    eol = "¬",
    tab = ">.",
    lead = ".",
    trail = "␣",
  }
  opt.diffopt = { "filler", "closeoff", "vertical" }
  opt.scrolloff = 8
  opt.splitbelow = true
  opt.splitright = true
  opt.exrc = true         -- Charger .nvim.lua local dans les projets
  opt.secure = true       -- Sécurité pour exrc

  g.matchparen_timeout = 20
  g.matchparen_insert_timeout = 20
  g.mapleader = "\\"
  g.guitablabel = "%f"
  g.python3_host_prog = "/usr/bin/python3"
  g.python_host_prog = "/usr/bin/python2"
end

local function setup_autocommands()
  local remember_group = vim.api.nvim_create_augroup("RememberFolds", { clear = true })
  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = remember_group,
    pattern = "*.*",
    callback = function()
      vim.cmd("mkview")
    end,
  })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = remember_group,
    pattern = "*.*",
    callback = function()
      vim.cmd("silent! loadview")
    end,
  })

  local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  local cursorline_group = vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", { clear = true })
  vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    group = cursorline_group,
    callback = function()
      vim.opt_local.cursorline = true
    end,
  })
  vim.api.nvim_create_autocmd("WinLeave", {
    group = cursorline_group,
    callback = function()
      vim.opt_local.cursorline = false
    end,
  })
end

function M.setup()
  apply_core_options()
  setup_colorscheme_preferences()
  setup_autocommands()
end

M.setup()

return M
