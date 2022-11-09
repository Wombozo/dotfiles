local M = { }

M.config = function()
  require("neo-tree").setup({
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added     = "✚",
          deleted   = "✖",
          modified  = "",
          renamed   = "",
          -- Status type
          -- untracked = "",
          -- ignored   = "",
          -- unstaged  = "",
          -- staged    = "",
          -- conflict  = "",
          ignored   = "",
          unstaged  = "",
          staged    = "",
        },
      },
    },
    close_if_last_window = true,
  })

end

M.use = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  requires = { 
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  }
}

return M
