local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  lspconfig['bashls'].setup{}
  lspconfig['sumneko_lua'].setup{
    cmd = {"lua-language-server", "-E", "/usr/lib/lua-language-server"};
  }

  lspconfig['ccls'].setup {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
          debounce_text_changes = 150,
       },
  }

end
return M
