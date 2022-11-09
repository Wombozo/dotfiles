local M = { }

M.config = function()
  -- LSP settings
  -- local function lspSymbol(name, icon, color)
  --   vim.fn.sign_define(
  --       'DiagnosticSign' .. name,
  --       { text = icon, numhl = 'DiagnosticDefault' .. name, texthl = color }
  --   )
  -- end
  -- lspSymbol('Error', 'E', 'Error')
  -- lspSymbol('Information', 'I', 'Information')
  -- lspSymbol('Hint', '', 'Hint')
  -- lspSymbol('Info', '', 'Information')
  -- lspSymbol('Warning', '', 'Warning')
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        severity_sort = true
    }
  )
  local nvim_lsp = require 'lspconfig'
  local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  end

  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  nvim_lsp['bashls'].setup{}
  --nvim_lsp['sumneko_lua'].setup{
  --  cmd = {"lua-language-server", "-E", "/usr/lib/lua-language-server"};
  --}

  nvim_lsp['sumneko_lua'].setup{
    on_attach = on_attach,
    cmd = {"lua-language-server", "-E", "/usr/lib/lua-language-server"},
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'},
        },
        completion = {
          callSnippet = "Disable",
          keywordSnippet = "Disable",
        },
      },
    },
  }

  nvim_lsp['ccls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
          debounce_text_changes = 150,
       },
  }

  nvim_lsp['tsserver'].setup{
    on_attach = on_attach,
  }

  nvim_lsp.jdtls.setup {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', '/usr/share/java/jdtls/config_linux',
      '-data', os.getenv "HOME" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    },
    -- root_dir = require'jdtls'.setup.find_root({'.git', 'mvnw', 'gradlew'}),
    settings = {
      java = {
      }
    },
    init_options = {
      bundles = {}
    },
    on_attach = on_attach
  }

  nvim_lsp.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
          ["rust-analyzer"] = {
              assist = {
                  importGranularity = "module",
                  importPrefix = "by_self",
              },
              cargo = {
                  loadOutDirsFromCheck = true
              },
              procMacro = {
                  enable = true
              },
          }
      }
  })
  require'trouble'.setup()
end

M.use = { 'neovim/nvim-lspconfig', 'folke/lsp-colors.nvim', 'folke/trouble.nvim', 'kyazdani42/nvim-web-devicons' }

return M
