return {
    on_attach = function (client, bufner)
        require("core.keymaps").attachFunction(bufner)
    end,
    settings = {
        Java = {
        }
    }
}
