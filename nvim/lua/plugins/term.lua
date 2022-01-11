require("toggleterm").setup{
  open_mapping = [[<leader>tt]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true,
  shell = vim.o.shell,
}


local Terminal  = require('toggleterm.terminal').Terminal

local term_float = Terminal:new({
  direction = 'float',
  cmd = './.nvim_exec',
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
function ExecToggle()
  term_float:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua GitToggle()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>te", "<cmd>lua ExecToggle()<CR>", {noremap = true, silent = true})
