return {
    on_attach = function(client, bufner)
        require('core.keymaps').attachFunction(bufner)
    end,
    cmd = {
        'clangd',
        '--clang-tidy',
        '--fallback-style=llvm',
    }
}
