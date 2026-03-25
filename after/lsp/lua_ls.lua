return {
    on_attach = function(client, bufner)
        require("core.keymaps").lspAttachFunction(bufner)
    end,
    diagnostics = {
        globals = { "vim", "require", "print" }
    },
    runtime = {
        version = "LuaJIT",
    }
}
