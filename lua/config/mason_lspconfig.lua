return {
    ensure_installed = { "lua_ls", "clangd" },
    automatic_enable = {
        exclude = {
            "jdtls",             -- Excluded here as nvim-jdtls handles client
        }
    }
}
