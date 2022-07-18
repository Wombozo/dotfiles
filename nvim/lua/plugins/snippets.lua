local M = { }

local ls = require("luasnip")
local snip = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local date = function() return {os.date('%Y-%m-%d')} end

M.config = function()
  ls.add_snippets("all", {
    snip({
        trig = "dateC",
        namr = "Date",
        dscr = "Date in the form of YYYY-MM-DD",
      }, {
        func(date, {}),
        }
    ),
  })
  ls.add_snippets("c", {
    snip({
        trig = "gui_c",
        namr = "Debug GUI",
        dscr = "Printout line and GUI marker"
      }, {
        text({"fprintf(stderr, \"<GUI> %s:%d\\n\", __func__, __LINE__);"})
        }
    ),
  })
  ls.add_snippets("lua", {
    snip({
        trig = "plugadd",
        namr = "Add a plugin",
        dscr = "Add a plugin with activable parameter"
      }, {
        text({"['"}), insert(1, "plugin_filename"), text({"'] = {",
        "\tactive = "}), insert(2, "true"), text({",",
        "},"})
        }
    ),
  })
end

M.use = { 'rafamadriz/friendly-snippets' }

return M
