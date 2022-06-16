local function map(mode, sc, cmd)
  return vim.api.nvim_set_keymap(mode, sc, cmd, {})
end

-- General -----------------------
map('n', '<C-q>', '<cmd>q<CR>')
-- - Easier buffer pick
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('t', '<C-h>', [[<C-\><C-n><C-W>h]])
map('t', '<C-l>', [[<C-\><C-n><C-W>l]])
map('t', '<C-j>', [[<C-\><C-n><C-W>j]])
map('t', '<C-k>', [[<C-\><C-n><C-W>k]])
---- Saving
map("n", "<C-s>", '<cmd>w<CR>')
map("i", "<C-s>", '<C-c><cmd>w<CR>')
---- Better Escape
map('t','jk', '<C-\\><C-n>')
---- Hidden characters
map('n', '<C-t>', '<cmd>set list!<CR>')
---- Splitting
map('n', '<C-w>s', '<cmd>split<CR>')
map('n', '<C-w>v', '<cmd>vsplit<CR>')
---- Resize vertical split faster
map('n', '<C-w>>', '<cmd>vertical resize +20<CR>')
map('n', '<C-w><', '<cmd>vertical resize -20<CR>')
---- Save selection to clipboard
map('v', '<leader>c', '"+y')
---- Move text up and down
map("n", "<C-PageDown>", "<cmd>m .+1<CR>==")
map("n", "<C-PageUp>", "<cmd>m .-2<CR>==")
map("v", "<C-PageDown>", "<cmd>m .+1<CR>==")
map("v", "<C-PageUp>", "<cmd>m .-2<CR>==")
map("x", "<C-PageDown>", "<cmd>move '>+1<CR>gv-gv")
map("x", "<C-PageUp>", "<cmd>move '<-2<CR>gv-gv")
---- Indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
---- Delete without saving in visual
map("v", "p", '"_dP')
---- Fold
map('n', 'zd', '<cmd>set nofoldenable<CR>')
map('n', 'ze', '<cmd>set foldenable<CR>')

-- Session -----------------------
map('n', '<leader>ss', '<cmd>lua require("persistence").load()<CR>')

-- Vista -------------------------
map('n','<C-a>', '<cmd>Vista!! <CR>')

-- Term --------------------------
map('n', '<leader>tt', "<cmd>lua TermToggle()<CR>")
-- map('n', "<leader>tg", "<cmd>lua GitToggle()<CR>")

-- Fugitive ---------------------
map('n', '<leader>gg', '<cmd>Git<CR>')
map('n', '<leader>gv', '<cmd>GV --all<CR>')
map('n', '<leader>gl', '<cmd>Gclog<CR>')
map('n', ']h', '<cmd>GitGutterNextHunk<CR>')
map('n', '[h', '<cmd>GitGutterPrevHunk<CR>')
map('n', '<leader>ge', '<cmd>GitGutterPreviewHunk<CR>')
map('n', '<leader>gf', '<cmd>GitGutterFold<CR>')

-- Telescope ---------------------
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fh', '<cmd>Telescope find_files hidden=true<CR>')
map('n', '<leader>fi', '<cmd>Telescope git_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>')
map('n', ';', "<cmd>lua require('telescope').extensions.neoclip.neoclip()<CR>")
map('n', '<leader>cd', '<cmd>Telescope zoxide list<CR>')
map('n', '<leader>?', '<cmd>Telescope keymaps<CR>')
map('n', '<leader>\'', '<cmd>Telescope marks<CR>')

-- Nvim-Tree ----------------------
map('n', '<C-n>', "<cmd>NvimTreeToggle<CR>")

-- Comments -----------------------
map('n', '<C-_>', ':CommentToggle <CR>')
map('v', '<C-_>', ':CommentToggle <CR>')

-- Bufferline --------------------------
map('n', '<TAB>', '<cmd>BufferLineCycleNext<CR>')
map('n', '<S-TAB>', '<cmd>BufferLineCyclePrev<CR>')
map('n', '<C-b>h', '<cmd>BufferLineMovePrev<CR>')
map('n', '<C-b>l', '<cmd>BufferLineMoveNext<CR>')
map('n', '<C-b>c', '<cmd>bdelete<CR>')
map('n', '<C-b>p', '<cmd>BufferLinePick<CR>')
map('n', '<C-b>tn', '<cmd>tabnew %<CR>')
map('n', '<C-b>tc', '<cmd>tabclose<CR>')

-- WRun --------------------------
map('n', '<leader>we', '<cmd>WRedit<CR>')
map('n', '<leader>wr', '<cmd>WRrun<CR>')
map('v', '<leader>wr', '<cmd>WRrun<CR>')
map('x', '<leader>wr', '<cmd>WRrun<CR>')
