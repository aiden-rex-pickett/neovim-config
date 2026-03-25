return {
    on_attach = function(client, bufner)
        require("core.keymaps").lspAttachFunction(bufner)
    end,
}
