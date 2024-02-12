local lspconfig = require('lspconfig')

lspconfig.clangd.setup {}
lspconfig.jedi_language_server.setup{}
lspconfig.nil_ls.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.tsserver.setup {}
