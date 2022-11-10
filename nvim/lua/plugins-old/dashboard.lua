local M = { }
M.config = function()
  local g = vim.g

  g.dashboard_disable_at_vimenter = 0
  g.dashboard_disable_statusline = 1
  g.dashboard_default_executive = "telescope"
  g.dashboard_custom_header = {
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
   " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
   " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
   " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
   " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
   " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
   " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
   "",
   "",
   "",
   "",

  }

  g.dashboard_custom_section = {
     a = { description = { "  Load Session              \\ s s" }, command = "lua require'persistence'.load()" },
     b = { description = { "  Find File                 \\ f f" }, command = "Telescope find_files" },
     c = { description = { "  Recents                   \\ f o" }, command = "Telescope oldfiles" },
     d = { description = { "  Find Word                 \\ f g" }, command = "Telescope live_grep" },
  }

  g.dashboard_custom_footer = {
     "NVIM",
  }
  -- local db = require('dashboard')
  -- db.custom_header  -- type can be nil,table or function(must be return table in function)
  --                   -- if not config will use default banner
  -- db.custom_center  -- table type and in this table you can set icon,desc,shortcut,action keywords. desc must be exist and type is string
  --                   -- icon type is nil or string
  --                   -- shortcut type is nil or string also like icon
  --                   -- action type can be string or function or nil.
  --                   -- if you don't need any one of icon shortcut action ,you can ignore it.
  -- db.custom_footer  -- type can be nil,table or function(must be return table in function)
  -- db.preview_file_Path    -- string type 
  -- db.preview_file_height  -- string type
  -- db.preview_file_width   -- string type
  -- db.preview_command      -- string type
  -- db.hide_statusline      -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
  -- db.hide_tabline         -- boolean default is true.it will hide tabline in dashboard buffer and auto open in other buffer
  -- db.session_directory    -- string type the directory to store the session file
  -- 
  -- -- example of db.custom_center for new lua coder,the value of nil mean if you
  -- -- don't need this filed you can not write it
  -- db.custom_center = {
  --   { icon = 'some icon' desc = 'some description here' } --correct if you don't action filed
  --   { desc = 'some description here' }                    --correct if you don't action and icon filed
  --   { desc = 'some description here' action = 'Telescope find files'} --correct if you don't icon filed
  -- }
end


M.use = { 'glepnir/dashboard-nvim' }

return M
