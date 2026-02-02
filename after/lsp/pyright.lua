return {
    on_attach = function(client, bufner)
        require("core.keymaps").attachFunction(bufner)
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            }
        }
    },
    handlers = {
        -- Disables diagnostics from Pyright as that is handled by ruf
        ["textDocument/publishDiagnostics"] = function() end 
    }
}
