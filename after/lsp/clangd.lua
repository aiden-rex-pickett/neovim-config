return {
    on_attach = function(client, bufner)
        require('core.keymaps').lspAttachFunction(bufner)
    end,
    cmd = {
        'clangd',
        '--clang-tidy',
        '--fallback-style=llvm',
    }
}
