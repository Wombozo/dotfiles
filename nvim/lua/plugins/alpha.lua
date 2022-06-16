local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
dashboard.section.header.val = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
  dashboard.button("\\ s s", "  Load Session", ":lua require'persistence'.load()<CR>"),
  dashboard.button("\\ f f", "  Find File", ":Telescope find_files<CR>"),
  dashboard.button("\\ f g", "  Find Word", ":Telescope live_grep<CR>"),
  dashboard.button("\\ f o", "  Recents", ":Telescope oldfiles<CR>"),
}
-- local handle = io.popen('fortune')
-- local fortune = handle:read("*a")
-- handle:close()
-- dashboard.section.footer.val = fortune
-- dashboard.config.opts.noautocmd = true
-- vim.cmd[[autocmd User AlphaReady echo 'ready']]
-- alpha.setup(dashboard.config)


local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

-- Send config to alpha
alpha.setup(dashboard.opts)
