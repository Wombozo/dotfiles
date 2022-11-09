local M = {}


M.config = function()
  require'noice'.setup({
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
      opts = { buf_options = { filetype = "vim" } },
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        help = { pattern = "^:%s*h%s+", icon = "" },
        input = {},
      },
    },
    messages = {
            enabled = true,
            view = "notify",
            view_error = "notify",
            view_warn = "notify",
            view_history = "split",
            view_search = false,
        },
        popupmenu = {
            enabled = true,
            backend = "nui",
            kind_icons = {},
        },
    views = {
      popupmenu = {
        zindex = 65,
        position = "auto",
        size = {
          width = "auto",
        },
        win_options = {
          winhighlight = {
            Normal = "NoiceBody",
            FloatBorder = "NoiceBorder",
            CursorLine = "PmenuSel",
            PmenuMatch = "Special",
          },
        },
        border = {
          padding = { 0, 1 },
          style = "rounded",
        },
      },
      notify = {
        backend = "notify",
        replace = true,
        format = "notify",
      },
      split = {
        backend = "split",
        enter = false,
        relative = "editor",
        position = "bottom",
        size = "20%",
        close = {
          keys = { "q", "<esc>" },
        },
        win_options = {
          winhighlight = { Normal = "NoiceBody", FloatBorder = "NoiceBorder" },
          wrap = true,
        },
      },
      vsplit = {
        backend = "split",
        enter = false,
        relative = "editor",
        position = "right",
        size = "20%",
        close = {
          keys = { "q", "<esc>" },
        },
        win_options = {
          winhighlight = { Normal = "NoiceBody", FloatBorder = "NoiceBorder" },
        },
      },
      popup = {
        backend = "popup",
        relative = "editor",
        close = {
          events = { "BufLeave" },
          keys = { "q" },
        },
        enter = true,
        border = {
          style = "rounded",
        },
        position = "50%",
        size = {
          width = "120",
          height = "20",
        },
        win_options = {
          winhighlight = { Normal = "NoiceBody", FloatBorder = "NoiceBorder" },
        },
      },
      hover = {
        view = "popup",
        relative = "cursor",
        zindex = 45,
        enter = false,
        anchor = "auto",
        size = {
          width = "auto",
          height = "auto",
          max_height = 20,
          max_width = 120,
        },
        position = { row = 1, col = 0 },
        win_options = {
          wrap = true,
          linebreak = true,
        },
      },
      cmdline = {
        backend = "popup",
        relative = "editor",
        position = {
          row = "100%",
          col = 0,
        },
        size = {
          height = "auto",
          width = "100%",
        },
        border = {
          style = "none",
        },
        win_options = {
          winhighlight = {
            Normal = "NoiceBody",
            FloatBorder = "NoiceBorder",
            IncSearch = "IncSearch",
            Search = "Search",
          },
        },
      },
      mini = {
        backend = "mini",
        relative = "editor",
        align = "message-right",
        timeout = 2000,
        reverse = false,
        position = {
          row = -2,
          col = "100%",
        },
        size = "auto",
        border = {
          style = { " ", " ", " ", " ", " ", " ", " ", " " },
        },
        zindex = 60,
        win_options = {
          winblend = 0,
          winhighlight = {
            Normal = "NoiceBody",
            IncSearch = "IncSearch",
            Search = "Search",
            FloatBorder = "NoiceBody",
          },
        },
      },
      cmdline_popup = {
        backend = "popup",
        relative = "editor",
        focusable = false,
        enter = false,
        zindex = 60,
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          min_width = 60,
          width = "auto",
          height = "auto",
        },
        border = {
          style = { " ", " ", " ", " ", " ", " ", " ", " " },
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "NoiceBody",
            FloatBorder = "NoiceBorder",
            IncSearch = "IncSearch",
            Search = "Search",
          },
          cursorline = false,
        },
      },
      confirm = {
        backend = "popup",
        relative = "editor",
        focusable = false,
        align = "center",
        enter = false,
        zindex = 60,
        format = { "{confirm}" },
        position = {
          row = "50%",
          col = "50%",
        },
        size = "auto",
        border = {
          style = { " ", " ", " ", " ", " ", " ", " ", " " },
          padding = { 0, 1, 0, 1 },
          text = {
            top = " CONFIRM: ",
          },
        },
        win_options = {
          winhighlight = {
            Normal = "NoiceBody",
            FloatBorder = "NoiceBorder",
          },
        },
      },
    }
  })
end

M.use = {
  "folke/noice.nvim",
  requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  }
}


return M
