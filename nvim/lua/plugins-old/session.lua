require('session-lens').setup {
  path_display = {'shorten'},
  theme_conf = { border = false },
  previewer = true
}
require("telescope").load_extension("session-lens")
