return {
    on_attach = function (client, bufner)
        require("core.keymaps").attachFunction(bufner)
    end,
    cmd = { 'superhtml', 'lsp' },
    filetypes = { 'superhtml', 'html', },
    root_markers = { 'index.html' },
    single_file_support = true,
}
