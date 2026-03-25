return {
    on_attach = function(client, bufner)
        require("core.keymaps").lspAttachFunction(bufner)
    end,
    cmd = { 'superhtml', 'lsp' },
    filetypes = { 'superhtml', 'html', },
    root_markers = { 'index.html' },
    single_file_support = true,
}
