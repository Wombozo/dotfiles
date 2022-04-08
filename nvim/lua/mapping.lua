local function map(mode, sc, cmd)
  return vim.api.nvim_set_keymap(mode, sc, cmd, {})
end

-- General -----------------------
-- map('n', '<CR>', '<cmd>')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('t','jk', '<C-\\><C-n>')
map('n', '<C-t>', '<cmd>set list!<CR>')
-- map('n', '<C-d>', '<cmd>q<CR>')
map('n', '<C-s>h', '<cmd>split<CR>')
map('n', '<C-s>v', '<cmd>vsplit<CR>')
map('v', '<leader>c', '"+y')
map('n', '<C-w>>', '<cmd>vertical resize +20<CR>')
map('n', '<C-w><', '<cmd>vertical resize -20<CR>')
map("n", "<C-j>", "<cmd>m .+1<CR>==")
map("n", "<C-k>", "<cmd>m .-2<CR>==")
map("v", "<C-j>", "<cmd>m .+1<CR>==")
map("v", "<C-k>", "<cmd>m .-2<CR>==")
map("x", "<C-j>", "<cmd>move '>+1<CR>gv-gv")
map("x", "<C-k>", "<cmd>move '<-2<CR>gv-gv")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", '"_dP')

-- Fold --------------------------
map('n', 'zd', '<cmd>set nofoldenable<CR>')
map('n', 'ze', '<cmd>set foldenable<CR>')

-- Vista -------------------------
map('n','<C-s>', '<cmd>Vista!! <CR>')

-- Term --------------------------
map('n', '<leader>tt', "<cmd>lua TermToggle()<CR>")
map('n', "<leader>tg", "<cmd>lua GitToggle()<CR>")

-- Telescope ---------------------
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fh', '<cmd>Telescope find_files hidden=true<CR>')
map('n', '<leader>fi', '<cmd>Telescope git_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>')
map('n', ';', "<cmd>lua require('telescope').extensions.neoclip.neoclip() <CR>")

-- Nvim-Tree ----------------------
map('n', '<C-n>', "<cmd>lua toggle_tree()<CR>")

-- Comments -----------------------
map('n', '<C-_>', ':CommentToggle <CR>')
map('v', '<C-_>', ':CommentToggle <CR>')

-- BarBar --------------------------
map('n', '<TAB>', '<cmd>BufferNext<CR>')
map('n', '<S-TAB>', '<cmd>BufferPrev<CR>')
map('n', 'bh', '<cmd>BufferMovePrevious<CR>')
map('n', 'bl', ' <cmd>BufferMoveNext<CR>')
--map('n', '<S-1>', '<cmd>BufferGoto 1<CR>')
--map('n', '<S-2>', '<cmd>BufferGoto 2<CR>')
--map('n', '<S-3>', '<cmd>BufferGoto 3<CR>')
--map('n', '<S-4>', '<cmd>BufferGoto 4<CR>')
--map('n', '<S-5>', '<cmd>BufferGoto 5<CR>')
--map('n', '<S-6>', '<cmd>BufferGoto 6<CR>')
--map('n', '<S-7>', '<cmd>BufferGoto 7<CR>')
--map('n', '<S-8>', '<cmd>BufferGoto 8<CR>')
--map('n', '<S-9>', '<cmd>BufferGoto 9<CR>')
--map('n', '<S-0>', '<cmd>BufferLast<CR>')
map('n', 'bc', '<cmd>BufferClose<CR>')
map('n', 'bp', '<cmd>BufferPick<CR>')

-- Keymaps -----------------------
map('n', '<leader>?', '<cmd>Telescope keymaps<CR>')

-- Marks -------------------------
map('n', '<leader>\'', '<cmd>Telescope marks<CR>')

-- WRun --------------------------
map('n', '<leader>we', '<cmd>WRedit<CR>')
map('n', '<leader>wr', '<cmd>WRrun<CR>')

-- Zoxide ------------------------
map('n', '<leader>cd', '<cmd>Telescope zoxide list<CR>')
