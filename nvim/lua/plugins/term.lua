require("toggleterm").setup{
  shading_factor = 0
}


local Terminal  = require('toggleterm.terminal').Terminal

local reg_term = Terminal:new({
  direction = 'horizontal',
  highlights = {
    border = "Normal",
    background = "Normal",
  }
})

local git = Terminal:new({
  cmd = "gitui",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
    width = 160,
    height = 100,
  },
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

local float_term = Terminal:new({
  direction = 'float',
  float_opts = {
    width = 100,
    height = 40,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
})

function GitToggle()
  git:toggle()
end

function ExecToggle()
  exec_float:toggle()
end

function TermToggle(toto)
  reg_term:toggle()
end
