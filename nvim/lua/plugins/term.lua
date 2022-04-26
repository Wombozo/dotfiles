require("toggleterm").setup{
  shading_factor = 0
}


local Terminal  = require('toggleterm.terminal').Terminal

local reg_term = Terminal:new({
  direction = 'horizontal',
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

function GitToggle()
  git:toggle()
end

function TermToggle()
  reg_term:toggle()
end
