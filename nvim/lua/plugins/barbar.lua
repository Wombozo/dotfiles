local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<S-Left>', ':BufferPrevious<CR>', opts)
map('n', '<S-Right>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<S-h>', ':BufferMovePrevious<CR>', opts)
map('n', '<S-l>', ' :BufferMoveNext<CR>', opts)
---- Goto buffer in position...
--map('n', '<S-1>', ':BufferGoto 1<CR>', opts)
--map('n', '<S-2>', ':BufferGoto 2<CR>', opts)
--map('n', '<S-3>', ':BufferGoto 3<CR>', opts)
--map('n', '<S-4>', ':BufferGoto 4<CR>', opts)
--map('n', '<S-5>', ':BufferGoto 5<CR>', opts)
--map('n', '<S-6>', ':BufferGoto 6<CR>', opts)
--map('n', '<S-7>', ':BufferGoto 7<CR>', opts)
--map('n', '<S-8>', ':BufferGoto 8<CR>', opts)
--map('n', '<S-9>', ':BufferGoto 9<CR>', opts)
--map('n', '<S-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<S-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map('n', '<S-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
