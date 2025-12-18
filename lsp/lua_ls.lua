return {
    on_attach = function (client, bufner)
        require("core.keymaps").attachFunction(bufner)
    end,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "require", "print" }
            },
            runtime = {
                version = "LuaJIT",
            }
        }
    }
}
