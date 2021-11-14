local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  lspconfig["ccls"].setup {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
          debounce_text_changes = 150,
       },
  }

  lspconfig['bashls'].setup{}

end
return M
