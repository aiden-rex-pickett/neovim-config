return {
    on_attach = function(client, bufner)
        require('core.keymaps').attachFunction(bufner)
    end,
    cmd = {
        'clangd',
        '--query-driver=C:\\MinGW\\bin\\gcc.exe',
        '--clang-tidy',
        '--fallback-style=llvm',
    }
}
