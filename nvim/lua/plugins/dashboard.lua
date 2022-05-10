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
