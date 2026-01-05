vim.diagnostic.config({
    virtual_text = {
        source = true,
    },
    update_in_insert = false,
    severity_sort = true,
    signs = false,
})

-- ADD ALL LSP ENABLES HERE (Except lua becuase it is by default in lua/plugins/lsp_config.lua under "ensure installed")
vim.lsp.enable('superhtml')
