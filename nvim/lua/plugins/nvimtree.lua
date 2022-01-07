local g = vim.g
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = git_status
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
g.nvim_tree_show_icons = {
   folders = 1,
   -- folder_arrows= 1
   files = 1,
   git = git_status,
}

g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      deleted = "",
      ignored = "◌",
      renamed = "➜",
      staged = "✓",
      unmerged = "",
      unstaged = "✗",
      untracked = "★",
   },
   folder = {
      -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
      arrow_open = "",
      arrow_closed = "",
      default = "",
      empty = "", -- 
      empty_open = "",
      open = "",
      symlink = "",
      symlink_open = "",
   },
}
require('nvim-tree').setup {
    diagnostics = {
      enable = false,
      icons = {
         hint = "",
         info = "",
         warning = "",
         error = "",
      },
   },
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard" },
   auto_close = true,
   open_on_tab = false,
   hijack_cursor = true,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   view = {
      allow_resize = true,
      side = "left",
      width = 30,
   },
   git = {
      enable = false,
      ignore = false,
      timeout = 500,
   }
}

--
--function toggle_tree()
--  if view.win_open() then
--    print('OPEN')
--    require'nvim-tree'.close()
--    require'bufferline.state'.set_offset(0)
--  else
--    print('CLOSE')
--    require'bufferline.state'.set_offset(31, 'File Explorer')
--    require'nvim-tree'.find_file(true)
--  end
--end


local nvim_tree = require'nvim-tree'
local view = require'nvim-tree.view'
local tabtab = require'bufferline.state'

function toggle_tree()
  if view.win_open() then
    nvim_tree.close()
    tabtab.set_offset(0)
  else
    nvim_tree.toggle()
    tabtab.set_offset(31, 'File Explorer')
    nvim_tree.find_file(true)
  end
end

--vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {})
vim.api.nvim_set_keymap('n', '<C-n>', ":lua toggle_tree()<CR>", {})
