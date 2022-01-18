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
local exec_float = Terminal:new({
  direction = 'float',
  --cmd = './.nvim_exec',
  cmd = '~/.local/bin/nvim_exec.sh',
  close_on_exit = true,
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

-- #~/.local/bin/nvim_exec.sh :
-- #!/bin/bash
-- 
-- path=$(pwd)
-- 
-- while [[ "${path}" != "/" ]]; do
--   if [[ -x "${path}/.nvim_exec" ]]; then
--     ${path}/.nvim_exec
--     read
--     exit 0
--   fi
--   path=$(dirname $path)
-- done
-- 
-- echo "No .nvim_exec found.. Press <Return> to exit"
-- read

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

function TermToggle()
  reg_term:toggle()
end

function FloatToggle()
  float_term:toggle()
end
