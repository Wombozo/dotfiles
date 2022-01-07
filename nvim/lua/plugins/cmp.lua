 local cmp = require'cmp'

 cmp.setup({
   snippet = {
     expand = function(args)
     end,
   },
   mapping = {
     ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
     ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
     ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
     ['<C-e>'] = cmp.mapping({
       i = cmp.mapping.abort(),
       c = cmp.mapping.close(),
     }),
     ['<CR>'] = cmp.mapping.confirm({ select = true }),
   },
   sources = cmp.config.sources({
     { name = 'nvim_lsp' },
   }, {
     { name = 'buffer' },
   }, {
     { name = 'path' },
   })
 })

 cmp.setup.cmdline('/', {
   sources = {
     { name = 'buffer' }
   }
 })

 cmp.setup.cmdline(':', {
   sources = cmp.config.sources({
     { name = 'path' }
   }, {
     { name = 'cmdline' }
   })
 })

 -- Setup lspconfig.
 local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
